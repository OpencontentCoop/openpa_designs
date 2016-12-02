{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>Progetto {$node.name|wash()}</h1>
    </div>

    {if $openpa.control_menu.show_side_menu}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if $openpa.control_menu.show_side_menu|not()} wide{/if}">

    {if $node|has_attribute( 'infographic' )}
      {def $infographic = $node|attribute( 'infographic' ).content.matrix.rows.sequential}
      {foreach $infographic as $i => $info}              
        
        {def $icon = $info.columns[0]
             $background = $info.columns[3]
             $text = $info.columns[1]
             $sub_text = $info.columns[2]}
        
        {if $i|eq(0)}<div class="row">{/if}
        <div class="col-lg-4 col-md-4 col-sm-4 m_bottom_45">
            <div class="r_corners bg_scheme_color infographic_item vc_child" style="background: {$background|wash()}">
                <div class="d_inline_middle d_md_block t_align_c">
                    <i class="fa {$icon|wash()} d_inline_middle m_right_15 color_light d_md_block m_md_bottom_5 m_md_right_0"></i>
                    <dl class="d_inline_middle color_light d_md_block">
                        <dt><b>{$text|wash()}</b></dt>
                        <dd class="fw_medium">{$sub_text|wash()}</dd>
                    </dl>
                </div>
            </div>
        </div>      
        {if eq(sum($i,1)|mod(6),0)}</div><div class="row">{/if}
        {if $i|eq(count($infographic)|sub(1))}</div>{/if}
        
        {undef $icon $background $text $sub_text}
        
      {/foreach}
      {undef $infographic}
    {/if}
    
    {if $node|has_attribute( 'abstract' )}
    <div class="well abstract">
      {attribute_view_gui attribute=$node|attribute( 'abstract' )}
    </div>
    {/if}
    
    {if $node|has_attribute( 'descrizione' )}    
      {attribute_view_gui attribute=$node|attribute( 'descrizione' )}    
    {/if}
    
    {def $testimonial = fetch( ezfind, search, hash( subtree_array, array( 1 ),
                                                     class_id, array( 'testimonial' ),
                                                     filter, array( concat( solr_meta_subfield('oggetto','id'),':', $node.contentobject_id ) ),
                                                     limit, 20,
                                                     sort_by, hash( published, desc ) ) )}
    {if $testimonial['SearchCount']|gt(0)}      
      
      <h2 class="tt_uppercase color_dark m_sm_bottom_15">Testimonianze</h2>
      
      <div class="testiomials_carousel carousel-top-control m_bottom_35">
        
        {include name="carousel"
                uri='design:atoms/carousel.tpl'
                items=$testimonial['SearchResult']
                css_id=concat('testimonials-',$node.node_id)
                root_node=$node
                autoplay=0
                pagination=false()
                navigation=true()
                items_per_row=1
                i_view=line}      
      </div>
    {/if}
	 


</div>
