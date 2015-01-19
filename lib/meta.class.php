<?php
/*
* META class
*
* Used by all modules to get meta titles
*
* @author Alex Ponomarenko <alex25853@gmail.com>
*/

class meta{
	public static function getMeta($page, $out) {
		switch($page){
			case 'main':
				$out['TITLE']="Редактирование пользователей";
				$out['description']="";
				$out['keywords']="";
			break;
			default:
				$out['TITLE']="Страница не найдена";
				$out['description']="";
				$out['keywords']="";
		}
	}  
}