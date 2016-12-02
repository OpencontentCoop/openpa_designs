{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">
        <h3>{$node.name|wash()}</h3>

        <div class="attribute-byline">
            <p class="author">Scritto <span class="date">{$node.object.published|l10n(date)}</span> da <strong>{$node.data_map.author.content|wash}</strong> alle ore <span class="time">{$node.object.published|l10n(shorttime)}</span></p>
        </div>

        <div class="attribute-long">
            {$node.data_map.message.content|wash(xhtml)|break|wordtoimage|autolink}
        </div>
    </div>
</div>