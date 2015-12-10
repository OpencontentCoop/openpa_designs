{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}
{ezpagedata_set( 'show_path', false() )}
<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">
        {attribute_view_gui attribute=$node.object.data_map.layout}
    </div>
</div>
