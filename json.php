<?php
require_once 'config.php';
mysql::getInstance();

header("Content-type: text/html; charset=utf-8");
if(!isset($_REQUEST['mode'])){
	$mode='';
}else{
	$mode=xss_clean($_REQUEST['mode']);
}
$page=(int)$_REQUEST['page'];
$avaible_mode= array('add_member','update_member','delete_member','update_members','search_members','sort_members');
$avaible_mode = array_flip ($avaible_mode);
if (!isset($avaible_mode[$mode])) $mode='';

if($mode==''){
	exit;
}
else{
	switch ($mode){
		case 'sort_members':
			$sort_by_elem=xss_clean($_REQUEST['sort_by']);
			$sort_by='';
			switch($sort_by_elem){
				case 'NAME': case 'LOGIN': case 'EMAIL': case 'ABOUT': case 'PRIVATE': case 'EMAIL_ORDERS':
					$sort_by=$sort_by_elem;
				break;
			}
			if($sort_by!=''){
				$_SESSION['sort_by']=$sort_by;
			}
			$members=new members();
			echo $members->returnJsonMembers($page);
		break;
		case 'add_member':
			$rec = Array();
			$rec['NAME'] = xss_clean($_REQUEST['name']); 
			$rec['LOGIN'] = xss_clean($_REQUEST['login']);  
			$rec['PASSWORD'] = md5(xss_clean($_REQUEST['password']));  
			$rec['EMAIL'] = xss_clean($_REQUEST['email']);  
			$rec['ABOUT'] = xss_clean($_REQUEST['about']);  
			$rec['PRIVATE'] = (int)$_REQUEST['private_per'];   
			$rec['EMAIL_ORDERS'] = (int)$_REQUEST['email_orders']; 
			$members=new members();
			if($members->createMember($rec)){
				echo $members->returnJsonMembers($page);
			}else echo 0;
		break;
		case 'update_member':
			$rec = Array();
			$rec['ID'] = (int)$_REQUEST['id']; 
			$rec['NAME'] = xss_clean($_REQUEST['name']); 
			$rec['LOGIN'] = xss_clean($_REQUEST['login']);  
			if(xss_clean($_REQUEST['password'])!='') $rec['PASSWORD'] = md5(xss_clean($_REQUEST['password']));  
			$rec['EMAIL'] = xss_clean($_REQUEST['email']);  
			$rec['ABOUT'] = xss_clean($_REQUEST['about']);  
			$rec['PRIVATE'] = (int)$_REQUEST['private_per'];   
			$rec['EMAIL_ORDERS'] = (int)$_REQUEST['email_orders']; 
			$members=new members();
			if($members->updateMember($rec)){
				$members->loadMembers($page);
				echo json_encode($members->getMembers());
			}else echo 0;
		break;
		case 'delete_member':
			$id = (int)$_REQUEST['id']; 
			$members=new members();
			if($members->deleteMember($id)){
				$members->loadMembers($page);
				echo json_encode($members->getMembers());
			}else echo 0;
		break;
		case 'update_members':
			#просто обновление странички
			$members=new members();
			echo $members->returnJsonMembers($page);
		break;
		case 'search_members':
			$input_search_select=xss_clean($_REQUEST['input_search_select']);
			$search_by='';
			#мало ли будут особые поиски (например по всем полям)
			switch($input_search_select){
				case 'NAME': case 'LOGIN': case 'EMAIL': case 'ABOUT': case 'PRIVATE': case 'EMAIL_ORDERS':
					$search_by=$input_search_select;
				break;
			}
			if($search_by!=''){
				$_SESSION['search_by']=$search_by;
				$_SESSION['search_text']=xss_clean($_REQUEST['input_search_text']);
			}
			$members=new members();
			echo $members->returnJsonMembers($page);
		break;
	}
	exit;
}