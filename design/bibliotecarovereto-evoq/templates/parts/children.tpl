{set_defaults( hash(
  'type', 'default'
))}

<section class="gray">
    <div class="container">
        {include uri=concat('design:parts/children/', $type, '.tpl')}
    </div>
</section>
