<?php if($action=='main'){ ?>
<h1>������ ������</h1>
<?php if(sizeof($data)==0){ ?>
	<h5>� ���� ���� ������</h5>
<?php }else{   ?>
	<table border="1px">
		<tr><th>ID</th><th>�������� ������</th><th>�������������� � ������</th><th>������</th><th>��������������</th></tr>
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
				
				
				echo '<tr><td>'.$val['id'].'</td><td>'.$val['name_ru'].'</td><td>'.$tek_city.'</td><td>'.$val['interest'].'%</td><td><a href="javascript:if (confirm(\'�������������?\')) document.location.href = \'/admin-discounts/edit/'.$val['id'].'/\'">�������������</a> / <a href="javascript:if (confirm(\'�������?\')) document.location.href = \'/admin-discounts/del/'.$val['id'].'/\'">�������</a></td></tr>';
				
			}
		?>
	</table>
<?php  } ?>
<br>
<a href="/admin-discounts/add/">�������� ������>></a><br>
<a href="/managment/">��������� �����</a>
<?php }elseif($action=='add'){ ?>
<h1>���������� ������</h1>
<br>
<script>
	function load_ingridients(){
		$.post("/json.php", { mode: "disc", city: $('#s_city').val() },
	   function(data) {
		 $('#d_ingr').html(data);
	   });
	}
	$(document).ready(function () {
		load_ingridients();
		$('#s_city').change(function() {
		  load_ingridients();
		});
		
		
	});
</script>
<form action="" method="POST">
	<div class="form">
		<div class="label">�������� ������:</div><div class="value"><input type="text" name="name_ru"></div><br><br>
		<div class="label">������ (%):</div><div class="value"><input type="text" name="interest"></div><br><br>
		<div class="label">�����:</div>
		<div class="value">
		<select name="city" id="s_city">
			<option value="0">���� �� ���� �������</option>
			<?php foreach($citys as $key=>$val): ?>
			<option value="<?php echo $val['id'] ?>"><?php echo $val['name_ru'] ?></option>	
			<?php endforeach; ?>
		</select>
		</div><br><br>
		<div class="label">����������� �� ���� ���������:</div><div class="value"><input type="checkbox" name="all_production"></div><br><br>
		<div id="d_ingr"></div>
		<div class="label"><input type="submit" value="��������"></div>
	</div>
</form>


<?php }elseif($action=='edit'){ ?>
<h1>�������������� ������</h1>
<br>
<script>
	function load_ingridients(){
		$.post("/json.php", { mode: "disc_by_id", city: $('#s_city').val() , id: '<?php echo $data['id'];  ?>' },
	   function(data) {
		 $('#d_ingr').html(data);
	   });
	}
	$(document).ready(function () {
		load_ingridients();
		$('#s_city').change(function() {
		  load_ingridients();
		});
		
		
	});
</script>

<form action="" method="POST">
	<div class="form">
		<div class="label">�������� ������:</div><div class="value"><input value="<?php echo $data['name_ru']; ?>" type="text" name="name_ru"></div><br><br>
		<div class="label">������ ($):</div><div class="value"><input type="text" name="interest" value="<?php echo $data['interest']; ?>"></div><br><br>
		<div class="label">�����:</div>
		<div class="value">
		<select name="city" id="s_city">
			<option value="0">���� �� ���� �������</option>
			<?php foreach($citys as $key=>$val): ?>
			<option value="<?php echo $val['id'] ?>" <?php if($val['id']==$data['city_id']){ echo'selected'; }  ?>><?php echo $val['name_ru'] ?></option>	
			<?php endforeach; ?>
		</select>
		</div><br><br>
		<div class="label">����������� �� ���� ���������:</div><div class="value"><input type="checkbox" <?php if($data['all_production']==1){ echo 'checked'; } ?> name="all_production"></div><br><br>
		<div id="d_ingr"></div>
		<div class="label"><input type="submit" value="��������"></div>
	</div>
</form>
<?php }?>