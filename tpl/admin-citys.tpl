<?php if($action=='main'){ ?>
<h1>������ �������</h1>
<?php if(sizeof($citys)==0){ ?>
	<h5>� ���� ���� �������</h5>
<?php }else{   ?>
	<table border="1px">
		<tr><th>ID</th><th>�������� ������</th><th>��������������</th></tr>
		<?php 
			foreach($citys as $key=>$val){
				echo '<tr><td>'.$val['id'].'</td><td>'.$val['name_ru'].'</td><td><a href="javascript:if (confirm(\'�������������?\')) document.location.href = \'/admin-citys/edit/'.$val['id'].'/\'">�������������</a> / <a href="javascript:if (confirm(\'�������?\')) document.location.href = \'/admin-citys/del/'.$val['id'].'/\'">�������</a></td></tr>';
			}
		?>
	</table>
<?php  } ?>
<br>
<a href="/admin-citys/add-city/">�������� �����>></a><br>
<a href="/managment/">��������� �����</a>
<?php }elseif($action=='add-city'){ ?>
<h1>���������� ������</h1>
<br>
<form action="" method="POST">
	<div class="form">
		<div class="label">�����:</div><div class="value"><input type="text" name="name_ru"></div><br><br>
		<div class="label"><input type="submit" value="��������"></div>
	</div>
</form>


<?php }elseif($action=='edit'){ ?>
<h1>�������������� ������</h1>
<br>
<form action="" method="POST">
	<div class="form">
		<div class="label">�����:</div><div class="value"><input value="<?php echo $city['name_ru']; ?>" type="text" name="name_ru"></div><br><br>
		<div class="label"><input type="submit" value="��������"></div>
	</div>
</form>
<?php }?>