{def $slides_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'HomeSliderNodeID', 'content.ini' ) ) )
     $banners=fetch('content','tree',
        hash(
            'parent_node_id', $slides_node.node_id,
            'sort_by', $slides_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('banner')))}

<section class="slider">
    <div class="container-fluid">
        <div class="row">
            {include uri='design:atoms/carousel.tpl'
                items=$banners
                root_node=$node
                title=false()
                autoplay=1
                controls=true()
                indicators= true()
                interval=10000
            }
            {*<div id="home-carousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#home-carousel" data-slide-to="0" class="active"></li>
                    <li data-target="#home-carousel" data-slide-to="1"></li>
                    <li data-target="#home-carousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img src="{'slide.jpg'|ezimage( 'no' )}" alt="First slide">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1 class="inverse">Gita virtuale in biblioteca per immagini</h1>
                                <p class="inverse second-line">GALLERIE FOTOGRAFICHE</p>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <img src="{'slide.jpg'|ezimage( 'no' )}" alt="Second slide">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>Gita virtuale in biblioteca per immagini</h1>
                                <p>GALLERIE FOTOGRAFICHE</p>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <img src="{'slide.jpg'|ezimage( 'no' )}" alt="Third slide">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1 class="inverse">Gita virtuale in biblioteca per immagini</h1>
                                <p class="inverse">GALLERIE FOTOGRAFICHE</p>
                            </div>
                        </div>
                    </div>
                </div>
                <a class="left carousel-control" href="#home-carousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#home-carousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div><!-- /.carousel -->*}
        </div>
    </div>
</section><!-- /.slider -->
