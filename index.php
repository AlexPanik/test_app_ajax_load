<?php
require_once 'config.php';
mysql::getInstance();



if(!isset($_REQUEST['mode'])){
	$mode='main';
}else{
	$mode=$_REQUEST['mode'];
}



$avaible_modules= array('main');
$avaible_modules = array_flip ($avaible_modules);
if (!isset($avaible_modules[$mode])) $mode='main';
$search_module = $mode;

header("Content-type: text/html; charset=utf-8");
if(file_exists(MODULES_DIR.$search_module.'.php')){
	meta::getMeta($search_module, &$out);
	require_once (MODULES_DIR.$search_module.'.php');
	require_once(TEMPLATES_DIR.'block/header.tpl');
    require_once(TEMPLATES_DIR.$search_module.'.tpl');
    require_once(TEMPLATES_DIR.'block/footer.tpl');
}else{
	die ('Модуль не найден!');
}
?>