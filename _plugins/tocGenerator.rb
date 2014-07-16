# -*- coding: utf-8 -*-
require 'nokogiri'

# this code is based on
# https://github.com/dafi/jekyll-toc-generator/blob/master/_plugins/tocGenerator.rb

module Jekyll

  module TOCGenerator

    ANCHOR_PREFIX = "toc"
    CONTENTS_LABEL = 'Contents'
    TOC_CONTAINER_HTML = '<div id="toc-container"><table class="toc" id="toc"><tbody><tr><td><div id="toctitle"><h2>%1</h2></div><ul>%2</ul></td></tr></tbody></table></div>'

    def toc_generate(html)

      # No Toc can be specified on every single page
      # For example the index page has no table of contents
      no_toc = @context.environments.first["page"]["noToc"] || false;

      if no_toc
        return html
      end

      doc = Nokogiri::HTML(html)

      toc_html = ''

      # Find H1 tag and all its H2 siblings until next H1
      doc.css('h1').each_with_index do |h1, h1_index|

        # TODO This XPATH expression can greatly improved
        ct  = h1.xpath('count(following-sibling::h1)')
        h2s = h1.xpath("following-sibling::h2[count(following-sibling::h1)=#{ct}]")

        level_html = '';

        h2s.map.each.with_index do |h2, h2_index|

          # either auto-generate an anchor or reuse the existing one
          if not h2['id'] then
            anchor_id = make_anchor(h1_index, h2_index)
            h2['id'] = "#{anchor_id}"
          else
            anchor_id = h2['id']
          end

          num = "%s.%s" % [h1_index+1, h2_index+1]
          level_html += create_level_html(anchor_id, num, h2.text.chomp(' ¶'), '')

        end

        if level_html.length > 0
          level_html = '<ul>' + level_html + '</ul>';
        end

        if not h1['id'] then
          anchor_id = make_anchor(h1_index)
          h1['id'] = "#{anchor_id}"
        else
          anchor_id = h1['id']
        end

        num = (h1_index+1).to_s
        toc_html += create_level_html(anchor_id, num, h1.text.chomp(' ¶'), level_html);

      end

      if toc_html.length > 0

        toc_table = TOC_CONTAINER_HTML
          .gsub('%1', CONTENTS_LABEL)
          .gsub('%2', toc_html);

        if doc.css('body > div#toc-container').size > 0 then
          doc.css('body > div#toc-container').first.replace(toc_table)
        else
          doc.css('body').children.before(toc_table)
        end

        doc.css('body').children.to_html()

      else
        return html
      end
    end

    private

    def make_anchor(*args)
      s = [ANCHOR_PREFIX]
      args.each{|a| s << (a+1).to_s }
      s.join("-")
    end

    def create_level_html(anchor_id, tocNumber, tocText, tocInner)
      '<li><a href="#%s"><span class="tocnumber">%s</span> <span class="toctext">%s</span></a>%s</li>' % [anchor_id, tocNumber, tocText, tocInner ? tocInner : '']
    end
  end
end

Liquid::Template.register_filter(Jekyll::TOCGenerator)
