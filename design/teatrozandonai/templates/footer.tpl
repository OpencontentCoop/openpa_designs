{def $root=fetch(content,node,hash(node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' )))}
<footer>
  <div class="footerBg" style="background-image:url({"footer-bg-demo.jpg"ezimage(no)});"></div>
  
  <div class="container">
    <div id="social">
      <a href="mailto:info@teatro-zandonai.it" title="Email"><img class="sprite email" src={"clear.png"|ezimage()} height="35" width="35" alt="Email"></a>
      <a href="https://www.facebook.com/pages/Teatro-Zandonai/573347456086785/" title="Facebook"><img class="sprite fb" src={"clear.png"|ezimage()} height="35" width="35" alt="Facebook"></a>
      <!--<a href="" title="Twitter"><img class="sprite tw" src={"clear.png"|ezimage()} height="35" width="35" alt="Twitter"></a>-->
      <a href="http://www.youtube.com/user/teatrozandonai" title="YouTube"><img class="sprite yt" src={"clear.png"|ezimage()} height="35" width="35" alt="YouTube"></a>
    </div><!--social-->

    <div id="contattiTeatro">
      {attribute_view_gui attribute=$root|attribute('info')}      
    </div><!--contattiTeatro-->
  </div><!--container-->
</footer>