<h1><?php echo $data['name_ru'] ?></h1>
<h2>������:</h2>
<?php foreach($ingr as $key=>$val){  
		foreach($allIngr as $k=>$v){  
			if($val['id']==$v['id'] && $val['ingr']!=''){
				echo  $v['name_ru'].': '.$val['ingr'].'<br>';
			}
			//print_r($val); 
		} 
	  }
 ?>
<h2>�����:</h2>
<?php 
	if($data['city_id']==0)
	echo '������������ �� ���� �������';
	else
	foreach($citys as $k=>$v){
		if($v['id']==$data['city_id']){
			echo $v['name_ru'];
		}
	}

?>


<br><br>
<a href="/">��������� �����</a>