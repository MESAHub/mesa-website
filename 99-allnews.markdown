---
layout: default
title: news archive
permalink: news.html
noToc: true
---

<h1>News Archive</h1>

This is an archive of all of the news posts that have ever appeared.

<ul class="posts">
  {% for post in site.posts %}
  {% capture year %}{{ post.date | date: "%Y" }}{% endcapture %}
  {% if year != oldyear %}<h2>{{ year }}</h2>{% endif %}
  {% capture oldyear %}{{ year }}{% endcapture %}

  <li><span>{{ post.date | date_to_string }}</span> <br>&raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
