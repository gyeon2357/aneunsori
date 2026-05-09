
<?php
declare(strict_types=1);
?>
<div class="content">
  <h2><?= html($pageTitle) ?></h2>
  <?php if ($myPages === []): ?>
    <p>아직 작성한 문서가 없습니다.</p>
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