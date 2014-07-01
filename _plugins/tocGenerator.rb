require 'nokogiri'

# this code is based on
# https://github.com/dafi/jekyll-toc-generator/blob/master/_plugins/tocGenerator.rb

module Jekyll

  module TOCGenerator

    TOGGLE_HTML = '<div id="toctitle"><h2>%1</h2>%2</div>'
    TOC_CONTAINER_HTML = '<div id="toc-container"><table class="toc" id="toc"><tbody><tr><td>%1<ul>%2</ul></td></tr></tbody></table></div>'

    def toc_generate(html)

      # No Toc can be specified on every single page
      # For example the index page has no table of contents
      no_toc = @context.environments.first["page"]["noToc"] || false;

      if no_toc
        return html
      end

      min_items_to_show_toc = 0
      anchor_prefix = 'toc-'
      contents_label = 'Contents'

      toc_html = ''
      toc_level = 1
      toc_section = 1
      item_number = 1
      level_html = ''

      doc = Nokogiri::HTML(html)

      # Find H1 tag and all its H2 siblings until next H1
      doc.css('h1').each do |h1|

        # TODO This XPATH expression can greatly improved
        ct  = h1.xpath('count(following-sibling::h1)')
        h2s = h1.xpath("following-sibling::h2[count(following-sibling::h1)=#{ct}]")

        level_html = '';
        inner_section = 0;

        h2s.map.each do |h2|

          inner_section += 1;

          # either auto-generate an anchor or reuse the existing one
          if not h2['id'] then 
            anchor_id = anchor_prefix + toc_level.to_s + '-' + toc_section.to_s + '-' + inner_section.to_s
            h2['id'] = "#{anchor_id}"
          else
            anchor_id = h2['id']
          end

          level_html += create_level_html(anchor_id,
                                          toc_level + 1,
                                          toc_section + inner_section,
                                          item_number.to_s + '.' + inner_section.to_s,
                                          h2.text,
                                          '')
        end
        if level_html.length > 0
          level_html = '<ul>' + level_html + '</ul>';
        end
        if not h1['id'] then
          anchor_id = anchor_prefix + toc_level.to_s + '-' + toc_section.to_s;
          h1['id'] = "#{anchor_id}"
        else
          anchor_id = h1['id']
        end

        toc_html += create_level_html(anchor_id,
                                      toc_level,
                                      toc_section,
                                      item_number,
                                      h1.text,
                                      level_html);

        toc_section += 1 + inner_section;
        item_number += 1;
      end

      # for convenience item_number starts from 1
      # so we decrement it to obtain the index count
      toc_index_count = item_number - 1

      if toc_html.length > 0
        hide_html = '';

        if min_items_to_show_toc <= toc_index_count
          replaced_toggle_html = TOGGLE_HTML
            .gsub('%1', contents_label)
            .gsub('%2', hide_html);
          toc_table = TOC_CONTAINER_HTML
            .gsub('%1', replaced_toggle_html)
            .gsub('%2', toc_html);
          doc.css('body').children.before(toc_table)
        end

        doc.css('body').children.to_html()

      else
        return html
      end
    end

    private
    
    def create_level_html(anchor_id, toc_level, toc_section, tocNumber, tocText, tocInner)
      link = '<a href="#%1"><span class="tocnumber">%2</span> <span class="toctext">%3</span></a>%4'
        .gsub('%1', anchor_id.to_s)
        .gsub('%2', tocNumber.to_s)
        .gsub('%3', tocText)
        .gsub('%4', tocInner ? tocInner : '');
      '<li class="toc_level-%1 toc_section-%2">%3</li>'
        .gsub('%1', toc_level.to_s)
        .gsub('%2', toc_section.to_s)
        .gsub('%3', link)
    end
  end
end

Liquid::Template.register_filter(Jekyll::TOCGenerator)
