<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
<meta name="theme-color" content="{{ theme.android_chrome_color }}">

{% if theme.daovoice %}
  <script>
  (function(i,s,o,g,r,a,m){i["DaoVoiceObject"]=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;a.charset="utf-8";m.parentNode.insertBefore(a,m)})(window,document,"script",('https:' == document.location.protocol ? 'https:' : 'http:') + "//widget.daovoice.io/widget/0f81ff2f.js","daovoice")
  daovoice('init', {
      app_id: "{{theme.daovoice_app_id}}"
    });
  daovoice('update');
  </script>
{% endif %}


{% if theme.pace %}
  {% set pace_css_uri = url_for(theme.vendors._internal + '/pace/'+ theme.pace_theme +'.min.css?v=1.0.2') %}
  {% set pace_js_uri = url_for(theme.vendors._internal + '/pace/pace.min.js?v=1.0.2') %}
    {% if theme.vendors.pace %}
      {% set pace_js_uri = theme.vendors.pace %}
    {% endif %}
    {% if theme.vendors.pace_css %}
      {% set pace_css_uri = theme.vendors.pace_css %}
    {% endif %}
  <script src="{{ pace_js_uri }}"></script>
  <link href="{{ pace_css_uri }}" rel="stylesheet">
{% endif %}


{% if theme.han %}
  {% set Han_uri = url_for(theme.vendors._internal + '/Han/dist/han.min.css?v=3.3') %}
  {% if theme.vendors.Han %}
    {% set Han_uri = theme.vendors.Han %}
  {% endif %}
  <link rel="stylesheet" media="all" href="{{ Han_uri }}">
{% endif %}


{# #238, Disable Baidu tranformation #}
<meta http-equiv="Cache-Control" content="no-transform" />
<meta http-equiv="Cache-Control" content="no-siteapp" />


{% if theme.google_site_verification %}
  <meta name="google-site-verification" content="{{ theme.google_site_verification }}" />
{% endif %}

{% if theme.bing_site_verification %}
  <meta name="msvalidate.01" content="{{ theme.bing_site_verification }}" />
{% endif %}

{% if theme.yandex_site_verification %}
  <meta name="yandex-verification" content="{{ theme.yandex_site_verification }}" />
{% endif %}


{% if theme.baidu_site_verification %}
  <meta name="baidu-site-verification" content="{{ theme.baidu_site_verification }}" />
{% endif %}


{% if theme.qihu_site_verification %}
  <meta name="360-site-verification" content="{{ theme.qihu_site_verification }}" />
{% endif %}


{% if theme.fancybox %}
  {% set fancybox_css_uri = url_for(theme.vendors._internal + '/fancybox/source/jquery.fancybox.css?v=2.1.5') %}
  {% if theme.vendors.fancybox_css %}
    {% set fancybox_css_uri = theme.vendors.fancybox_css %}
  {% endif %}
  <link href="{{ fancybox_css_uri }}" rel="stylesheet" type="text/css" />
{% endif %}

{% include "./head/external-fonts.swig" %}

{% set font_awesome_uri = url_for(theme.vendors._internal + '/font-awesome/css/font-awesome.min.css?v=4.6.2') %}
{% if theme.vendors.fontawesome %}
  {% set font_awesome_uri = theme.vendors.fontawesome %}
{% endif %}
<link href="{{ font_awesome_uri }}" rel="stylesheet" type="text/css" />

<link href="{{ url_for(theme.css) }}/main.css?v={{ theme.version }}" rel="stylesheet" type="text/css" />

{% if theme.favicon.apple_touch_icon %}
  <link rel="apple-touch-icon" sizes="180x180" href="{{ url_for(theme.favicon.apple_touch_icon) }}?v={{ theme.version }}">
{% endif %}
{% if theme.favicon.medium %}
  <link rel="icon" type="image/png" sizes="32x32" href="{{ url_for(theme.favicon.medium) }}?v={{ theme.version }}">
{% endif %}
{% if theme.favicon.small %}
  <link rel="icon" type="image/png" sizes="16x16" href="{{ url_for(theme.favicon.small) }}?v={{ theme.version }}">
{% endif %}
{% if theme.favicon.safari_pinned_tab %}
  <link rel="mask-icon" href="{{ url_for(theme.favicon.safari_pinned_tab) }}?v={{ theme.version }}" color="{{ theme.android_chrome_color }}">
{% endif %}
{% if theme.favicon.android_manifest %}
  <link rel="manifest" href="{{ url_for(theme.favicon.android_manifest) }}">
{% endif %}
{% if theme.favicon.ms_browserconfig %}
  <meta name="msapplication-config" content="{{ url_for(theme.favicon.ms_browserconfig) }}" />
{% endif %}

{% if page.keywords %}
  <meta name="keywords" content="{{ page.keywords }}" />
{% elif page.tags and page.tags.length %}
  <meta name="keywords" content="{% for tag in page.tags %}{{ tag.name }},{% endfor %}" />
{% elif theme.keywords %}
  <meta name="keywords" content="{{ theme.keywords }}" />
{% endif %}


{% if theme.rss === '' and config.feed and config.feed.path %}
  {% set theme.rss = config.feed.path %}
{% endif %}
{% if theme.rss %}
  <link rel="alternate" href="{{ url_for(theme.rss) }}" title="{{ config.title }}" type="application/atom+xml" />
{% endif %}


{% if theme.facebook_sdk.enable and theme.facebook_sdk.webmaster %}
  <meta property="fb:admins" content="{{ theme.facebook_sdk.fb_admin }}" />
  <meta property="fb:app_id" content="{{ theme.facebook_sdk.app_id }}" />
{% endif %}


{{
  open_graph({
    twitter_id: theme.twitter,
    google_plus: theme.google_plus,
    fb_admins: theme.fb_admins,
    fb_app_id: theme.fb_app_id
  })
}}


{# Export some HEXO Configurations to Front-End #}
<script type="text/javascript" id="hexo.configurations">
  var NexT = window.NexT || {};
  var CONFIG = {
    root: '{{ theme.root }}',
    scheme: '{{ theme.scheme }}',
    version: '{{ theme.version }}',
    sidebar: {{ theme.sidebar | json_encode }},
    fancybox: {{ theme.fancybox }},
    tabs: {{ theme.tabs.enable }},
    motion: {{ theme.motion | json_encode }},
    duoshuo: {
      userId: '{{ theme.duoshuo_info.user_id | default() }}',
      author: '{{ theme.duoshuo_info.admin_nickname | default(__('author'))}}'
    },
    algolia: {
      applicationID: '{{ theme.algolia.applicationID }}',
      apiKey: '{{ theme.algolia.apiKey }}',
      indexName: '{{ theme.algolia.indexName }}',
      hits: {{ theme.algolia_search.hits | json_encode }},
      labels: {{ theme.algolia_search.labels | json_encode }}
    }
  };
</script>

{# Canonical, good for google search engine (SEO) : https://support.google.com/webmasters/answer/139066 #}
{% if theme.canonical %}
  <link rel="canonical" href="{{ config.url }}/{{ page.canonical_path.replace('index.html', '') }}"/>
      <a href="https://github.com/mySoul8012" class="github-corner" aria-label="View source on Github"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#70B7FD; color:#fff; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style>

{% endif %}

{% include 'head/custom-head.swig' %}
