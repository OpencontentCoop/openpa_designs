{ezpagedata_set( 'has_container', true() )}
<div id="main-container" class="layout-page">

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12 column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <p class="lead">{attribute_view_gui attribute=$node|attribute( 'short_name' )}</p>
                    </header>

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'abstract' )}
                        <hr class="spacer">
                        {attribute_view_gui attribute=$node|attribute( 'description' )}
                    </div>

                    <hr class="spacer">

                    <div class="dataTables_wrapper table-responsive" id="data-contents">
                        <table class="table table-bordered table-striped" id="id-{$node.node_id}">
                            <thead>
                            <tr>
                                <th class="sorter sorting" data-field="name">Nome</th>
                                <th class="sorter sorting" data-field="raw[extra_data_morte_dt]">Data di morte</th>
                                <th class="sorter sorting" data-field="raw[attr_luogo_morte_s]">Luogo di morte</th>
                                <th class="sorter sorting" data-field="raw[extra_data_nascita_dt]">Data di nascita</th>
                            </tr>
                            <tr>
                                <th class="finder"><input data-field="raw[{solr_meta_field('name')}]" type="text" class="form-control" placeholder="Cerca per nome" /></th>
                                <th class="finder"><input data-field="raw[{solr_field('data_morte', 'text')}]" type="text" class="form-control" placeholder="Cerca per data di morte" /></th>
                                <th class="finder"><input data-field="raw[{solr_field('luogo_morte', 'text')}]" type="text" class="form-control" placeholder="Cerca per luogo di morte" /></th>
                                <th class="finder"><input data-field="raw[{solr_field('data_nascita', 'text')}]" type="text" class="form-control" placeholder="Cerca per data di nascita" /></th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>

                </div><!-- /.column-content -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>

<div id="preview" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="previewlLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="padding: 20px;">
        </div>
    </div>
</div>

{ezscript_require(array(
    'ezjsc::jquery',
    'ezjsc::jqueryUI',
    'bootstrap/modal.js',
    'jquery.opendataTools.js',
    'moment-with-locales.min.js',
    'jsrender.js',
    'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js"
))}
{ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}
{literal}
<script id="tpl-results" type="text/x-jsrender">
<tr>
	<td colspan="4" class="text-center"><em>Trovati {{:totalCount}} documenti</em></td>
</tr>
{{for searchHits}}
<tr>
	<td style="white-space:nowrap">
	    <a class="view-object"
	       href="#"
	       data-node="{{:metadata.mainNodeId}}"
	       data-load-remote="/layout/set/modal/content/view/full/{{:metadata.mainNodeId}}"
           data-remote-target="#preview .modal-content"
           data-target="#preview">
	        {{:~i18n(metadata.name)}}
	    </a>
    </td>
	<td>{{if ~i18n(data, 'data_morte')}}{{:~i18n(data, 'data_morte')}}{{/if}}</td>
	<td>{{if ~i18n(data, 'luogo_morte')}}{{:~i18n(data, 'luogo_morte')}}{{/if}}</td>
	<td>{{if ~i18n(data, 'data_nascita')}}{{:~i18n(data, 'data_nascita')}}{{/if}}</td>
</tr>
{{/for}}
<tr>
	<td colspan="4" class="text-right">
		{{if prevPageQuery}}
			<a href="#data-contents" id="prevPage" data-query="{{>prevPageQuery}}"><i class="fa fa-arrow-left"></i></a>
		{{/if}}
		{{if nextPageQuery }}
			<a href="#data-contents" id="nextPage" data-query="{{>nextPageQuery}}"><i class="fa fa-arrow-right"></i></a>
		{{/if}}
	</td>
</tr>
</script>
<script id="tpl-spinner" type="text/x-jsrender">
<tr>
	<td colspan="4" class="text-center">
        <i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>
        <span class="sr-only">{'Loading...'|i18n('booking')}</span>
    </td>
</tr>
</script>
<style>
    th.sorter{min-width: 150px;}
    .dataTables_wrapper .sorting:after,
    .dataTables_wrapper .sorting_asc:after,
    .dataTables_wrapper .sorting_desc:after { float: left; margin-right: .5em}
    .modal-dialog {width: 90%;}
</style>
{/literal}

<script type="text/javascript" language="javascript">
    var ParentNodeId = {$node.node_id};
    var ContainerSelector = "#id-{$node.node_id}";
    var FormSelector = "#detail-form";
    var ClassIdentifier = "santino";
    {literal}
    var tools = $.opendataTools;
    $.views.helpers(tools.helpers);

    $(document).ready(function () {

        var pageLimit = 50;
        var template = $.templates('#tpl-results');
        var classQuery = '';
        if (ClassIdentifier){
            classQuery = 'classes ['+ClassIdentifier+'] ';
        }
        var mainQuery = classQuery+'subtree [' + ParentNodeId + '] sort [name=>asc] limit ' + pageLimit;
        var $container = $(ContainerSelector).find('tbody');
        $('th.sorting[data-field="name"]').removeClass('sorting').addClass('sorting_asc');

        var buildQuery = function () {
            var sortField = $('th.sorting_asc').data('field');
            var sort = 'asc';
            if (!sortField){
                sortField = $('th.sorting_desc').data('field');
                sort = 'desc';
            }
            var sortParams = '['+sortField+'=>'+sort+']';

            var filterParts = [];
            $('th.finder input').each(function () {
                var value = $(this).val();
                var field = $(this).data('field');
                if (value.length > 0){
                    value = value.replace(/"/g, '\\\"')
                        .replace(/'/g, "\\'")
                        .replace(/\(/g, "\\(")
                        .replace(/\)/g, "\\)");
                    filterParts.push(field + ' = ' + "'\"" + value + "\"'");
                }
            });
            var filters = '';
            if (filterParts.length > 0) {
                filters = filterParts.join(' and ') + ' and ';
            }

            var query = filters+classQuery+'subtree [' + ParentNodeId + '] sort '+sortParams+' limit ' + pageLimit;

            return query;
        };

        var currentPage = 0;
        var queryPerPage = [];

        var runQuery = function (query) {
            $container.html($.templates('#tpl-spinner').render());
            tools.find(query, function (response) {
                queryPerPage[currentPage] = query;
                response.currentPage = currentPage;
                response.prevPageQuery = jQuery.type(queryPerPage[currentPage - 1]) === "undefined" ? null : queryPerPage[currentPage - 1];

                var renderData = $(template.render(response));

                $container.html(renderData);

                renderData.find('.view-object').on('click', function (e) {
                    e.preventDefault();
                    var $this = $(this);
                    var remoteTarget = $($this.data('remote-target'));
                    var node = $($this).data('node');
                    remoteTarget.html('<em>Caricamento...</em>');
                    var remote = $this.data('load-remote');
                    if (remote) {
                        $.get(remote, function (response) {
                            remoteTarget.html($(response).find('section.main-content .column-content').html());
                            remoteTarget.prepend('<div class="clearfix"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></div>');
                            remoteTarget.find('header h2 span').wrap('<a href="/content/view/full/'+node+'"></a>');
                            $($this.data('target')).modal('show');
                        });
                    }

                    e.preventDefault();
                });

                $container.find('#nextPage').on('click', function (e) {
                    currentPage++;
                    runQuery($(this).data('query'));
                });

                $container.find('#prevPage').on('click', function (e) {
                    currentPage--;
                    runQuery($(this).data('query'));
                });
                $('th.finder input').tooltip('hide');
            });
        };

        var loadContents = function () {
            var query = buildQuery();
            runQuery(query);
        };

        $('th.sorter').on('click', function (e) {
            var self = $(this);
            if (self.hasClass('sorting_asc')){
                self.removeClass('sorting_asc').addClass('sorting_desc');
            }else if (self.hasClass('sorting_desc')){
                self.removeClass('sorting_desc').addClass('sorting_asc');
            }else {
                self.addClass('sorting_asc');
                self.siblings().removeClass('sorting_desc sorting_asc').addClass('sorting');
            }
            currentPage = 0;
            loadContents();
            e.preventDefault();
        });

        $('th.finder input').on('change', function (e) {
            loadContents();
        }).on('keydown', function (e) {
            if(e.keyCode === 13) {
                loadContents();
            }
        }).tooltip({'trigger':'focus', 'title': 'Digita un testo e premi invio'});

        loadContents();
    });
    {/literal}
</script>