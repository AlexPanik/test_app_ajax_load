<?php if($action=='main'){ ?>
<h1>������ ��������</h1>
<?php if(sizeof($data)==0){ ?>
	<h5>� ���� ���� ��������</h5>
<?php }else{   ?>
	<table border="1px">
		<tr><th>ID</th><th>�������� ���������</th><th>�������������� � ������</th><th>����</th><th>��������������</th></tr>
		<?php 
			foreach($data as $key=>$val){
				$tek_city='';
				if($val['city_id']==0){
					$tek_city='������������ �� ���� �������';
				}else{
					foreach($citys as $k=>$v){
						if($v['id']==$val['city_id']){
							$tek_city=$v['name_ru'];
						}
					}
				}
				$price='';
				if($val['cost']==0){
					$price='���������';
				}
				else{
					$price=$val['cost'].'$';
				}
				echo '<tr><td>'.$val['id'].'</td><td>'.$val['name_ru'].'</td><td>'.$tek_city.'</td><td>'.$price.'</td><td><a href="javascript:if (confirm(\'�������������?\')) document.location.href = \'/admin-packages/edit/'.$val['id'].'/\'">�������������</a> / <a href="javascript:if (confirm(\'�������?\')) document.location.href = \'/admin-packages/del/'.$val['id'].'/\'">�������</a></td></tr>';
				
			}
		?>
	</table>
<?php  } ?>
<br>
<a href="/admin-packages/add/">�������� ���������>></a><br>
<a href="/managment/">��������� �����</a>
<?php }elseif($action=='add'){ ?>
<h1>���������� ���������</h1>
<br>
<form action="" method="POST">
	<div class="form">
		<div class="label">���������:</div><div class="value"><input type="text" name="name_ru"></div><br><br>
		<div class="label">�����:</div>
		<div class="value">
		<select name="city">
			<option value="0">���� �� ���� �������</option>
			<?php foreach($citys as $key=>$val): ?>
			<option value="<?php echo $val['id'] ?>"><?php echo $val['name_ru'] ?></option>	
			<?php endforeach; ?>
		</select>
		</div><br><br>
		<div class="label">���� ($):</div><div class="value"><input type="text" name="cost"></div><br><br>
		<div class="label">������� ��� ������ �� ($):</div><div class="value"><input type="text" name="price_free"></div><br><br>
		<div class="label"><input type="submit" value="��������"></div>
	</div>
</form>


<?php }elseif($action=='edit'){ ?>
<h1>�������������� �����������</h1>
<br>
<form action="" method="POST">
	<div class="form">
		<div class="label">����������:</div><div class="value"><input value="<?php echo $data['name_ru']; ?>" type="text" name="name_ru"></div><br><br>
		<div class="label">�����:</div>
		<div class="value">
		<select name="city">
			<option value="0">���� �� ���� �������</option>
			<?php foreach($citys as $key=>$val): ?>
			<option value="<?php echo $val['id'] ?>" <?php if($val['id']==$data['city_id']){ echo'selected'; }  ?>><?php echo $val['name_ru'] ?></option>	
			<?php endforeach; ?>
		</select>
		</div><br><br>
		<div class="label">���� ($):</div><div class="value"><input type="text" name="cost" value="<?php echo $data['cost']; ?>"></div><br><br>
		<div class="label">������� ��� ������ �� ($):</div><div class="value"><input type="text" name="price_free" value="<?php echo $data['price_free']; ?>"></div><br><br>
		<div class="label"><input type="submit" value="��������"></div>
	</div>
</form>
<?php }?>