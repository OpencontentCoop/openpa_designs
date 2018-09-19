{ezscript_require( array(
'ezjsc::jquery',
'jquery.opendataTools.js',
'moment-with-locales.min.js',
'jsrender.js'
))}

{def $current_language=ezini('RegionalSettings', 'Locale')}
{def $moment_language = $current_language|explode('-')[1]|downcase()}


<script>
  moment.locale('{$moment_language}');
  $.opendataTools.settings('is_collaboration_enabled', 'false');
  $.opendataTools.settings('endpoint',{ldelim}
    'geo': '{'/opendata/api/geo/search/'|ezurl(no,full)}/',
    'search': '{'/opendata/api/content/search/'|ezurl(no,full)}/',
    'class': '{'/opendata/api/classes/'|ezurl(no,full)}/',
    'tags_tree': '{'/opendata/api/tags_tree/'|ezurl(no,full)}/',
    'fullcalendar': '{'/opendata/api/fullcalendar/search/'|ezurl(no,full)}/'
      {rdelim});
  $.opendataTools.settings('accessPath', "{''|ezurl(no,full)}");
  $.opendataTools.settings('language', "{$current_language}");
  $.opendataTools.settings('base_query', "{$base_query}");
  $.opendataTools.settings('locale', "{$moment_language}");
  $.opendataTools.settings('agenda_url', "http://{agenda_site_url()}");


  {literal}
  $( document ).ready(function() {

    var i18n = function (data, key, fallbackLanguage) {
      var currentLanguage = $.opendataTools.settings['language'];
      fallbackLanguage = fallbackLanguage || 'ita-IT';
      var returnData = false;
      if (data && key) {
        if (typeof data[currentLanguage] != 'undefined' && data[currentLanguage][key]) {
          returnData = data[currentLanguage][key];
        }
        else if (fallbackLanguage && typeof data[fallbackLanguage] != 'undefined' && data[fallbackLanguage][key]) {
          returnData = data[fallbackLanguage][key];
        }
      } else if (data) {
        if (typeof data[currentLanguage] != 'undefined' && data[currentLanguage]) {
          returnData = data[currentLanguage];
        }
        else if (fallbackLanguage && typeof data[fallbackLanguage] != 'undefined' && data[fallbackLanguage]) {
          returnData = data[fallbackLanguage];
        }
      }
      return returnData != 0 ? returnData : false;
    };



    $.opendataTools.find('calendar[] = ['+ moment().format('YYYY-MM-DD')+',*] and state in [moderation.skipped,moderation.accepted] classes [agenda_event]', function( data ) {
      var template = $.templates('#tpl-results');
      var helpers = {
        'formatDate': function (date, format) {
          moment.locale($.opendataTools.settings['locale']);
          return moment(new Date(date)).format(format);
        },
        'mainImageUrl': function (data) {
          var images = i18n(data, 'images');
          if (images.length > 0) {
            return $.opendataTools.settings['accessPath'] + '/agenda/image/' + images[0].id;
          }
          var image = i18n(data, 'image');
          if (image) {
            return image.url;
          }
          return null;
        },
        'settings': function (setting) {
          return $.opendataTools.settings[setting];
        },
        'language': function (setting) {
          return language(setting);
        },
        'i18n': function (data, key, fallbackLanguage) {
          return i18n(data, key, fallbackLanguage);
        },
        'agendaRoot': function () {
          /*return $.opendataTools.settings['agenda_url'];*/
          return 'http://rovereto.agenda.opencontent.it';
        },
        'agendaUrl': function (id) {
          return 'http://rovereto.agenda.opencontent.it/agenda/event/' + id;
        },
        'associazioneUrl': function (objectId) {
          return 'http://rovereto.agenda.opencontent.it/openpa/object/' + objectId;
        }
      };
      
      if ($.views) {
        $.views.helpers(helpers);
      }
      else {
        jsrender.views.helpers(helpers);
      }

      var container = $('.agendawidget')
      $wrapper = $('<div style="height:{/literal}{$height}{literal};overflow-y: auto"></div>');
      if(!data.error_message && data.totalCount > 0){

        var renderData = $(template.render(data));
        container.html(renderData);


      }else{
        container.hide().html('<small><em>'+data.data.error_message+'</em></small>');
      }
      
    });
  });
  {/literal}

</script>

{literal}

    <style>
        .agendawidget {
            margin: 20px 0;
            background-color: #efefef;
            padding: 20px;
        }
    </style>
<script id="tpl-results" type="text/x-jsrender">

<h2>Calendario della Città</h2>
{{for searchHits}}

<div class="class-pubblicazione line clearfix">
    <h3>
       <a href="{{:~agendaUrl(metadata.mainNodeId)}}" title="{{:~i18n(data,'titolo')}}">{{:~i18n(data,'titolo')}}</a>
    </h3>

    {{if ~i18n(data,'image')}}
        <div class="main-image">
            <a href="{{:~agendaUrl(metadata.mainNodeId)}}">
                <img src="{{:~i18n(data,'image').url}}" width="150" />
            </a>
        </div>
    {{/if}}

    <p class="details">
        {{:~i18n(data,'recurrences').text}}
    </p>
    <p class="details">
        {{if ~i18n(data,'luogo')}}{{for ~i18n(data,'luogo')}}{{>~i18n(name)}}{{/for}}{{else}}{{if ~i18n(data,'luogo_svolgimento')}}{{:~i18n(data,'luogo_svolgimento')}}{{/if}}{{/if}}
    </p>
</div>
{{/for}}
<h4><a href="{{:~agendaRoot()}}" class="pull-right"><i class="fa fa-calendar"></i> Vai al calendario completo</a></h3>
</script>
{/literal}

<div class="agendawidget"></div>