<h1><?php echo $title; ?></h1>
<br>
<a href="/make-hamburger/">������ ���� ���������</a><br>
<a href="/make-order/">������ �����</a><br>
<br>
<b>��������� ���������:</b><br>
<?php foreach($pr as $key=>$val): ?>
	<a href="/production/<?php echo $val['id'] ?>/"><?php echo $val['name_ru'] ?></a><br>
<?php endforeach; ?>

<br>
<b>������� �������������:</b><br>
<?php foreach($urPr as $key=>$val): ?>
	<a href="/user-production/<?php echo $val['id'] ?>/"><?php echo $val['name_ru'] ?></a><br>
<?php endforeach; ?>