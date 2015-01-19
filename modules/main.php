<?php
	$members=new members();
	$members->loadMembers(1);
	$out['users']=$members->getMembers();
	$out['pagination']=$members->getPagination();
	
	
	$out['sort_by']=$_SESSION['sort_by'];
	$out['search_by']=$_SESSION['search_by'];
	$out['search_text']=$_SESSION['search_text'];