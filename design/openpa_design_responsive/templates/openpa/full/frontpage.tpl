{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}
{* EDITOR TOOLS *}
{include name = editor_tools
         node = $node             
         uri = 'design:parts/openpa/editor_tools.tpl'}
{attribute_view_gui attribute=$node.object.data_map.page}
