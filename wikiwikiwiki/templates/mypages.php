<?php

declare(strict_types=1);
?>
<div class="content">
  <h1><?= html($pageTitle) ?></h1>
  <?php if ($myPages === []): ?>
    <p><?= html(t('mypages.empty')) ?></p>
  <?php else: ?>
    <ul data-columns>
      <?php foreach ($myPages as $page): ?>
        <?php $title = (string) ($page['title'] ?? '') ?>
        <?php if ($title === '') continue ?>
        <li><a href="<?= html(url($title)) ?>"><?= html($title) ?></a></li>
      <?php endforeach ?>
    </ul>
  <?php endif ?>
</div>