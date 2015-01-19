<?php
/*
*
* Used by all modules to work with members
*
* @author Alex Ponomarenko <alex25853@gmail.com>
*/

class members{
	protected $members=Array();
	protected $members_count=0;
	protected $page=1;
	protected $count_pages=1;
	protected $pagination=Array();
	
	public function loadMembers($page) {
		if($page>1) $this->page=$page;
		$from=($this->page-1)*PER_PAGE;
		
		$sort_by='id DESC';
		if(isset($_SESSION['sort_by']) && $_SESSION['sort_by']!='')  $sort_by=$_SESSION['sort_by'];
		
		if(isset($_SESSION['search_by']) && $_SESSION['search_by']!=''){
			$this->members=mysql::Select("SELECT * FROM `members` WHERE ".$_SESSION['search_by']." LIKE '%".$_SESSION['search_text']."%' ORDER BY $sort_by LIMIT $from, ".PER_PAGE);
		}else{	
			$this->members=mysql::Select("SELECT * FROM `members` ORDER BY $sort_by LIMIT $from, ".PER_PAGE);
		}
		$this->prepareMembers();
		$count=mysql::SelectOne("SELECT COUNT(*) as C FROM `members`");
		$this->members_count=(int)$count['C'];
		
		$this->count_pages=ceil($this->members_count/PER_PAGE);
		for($i=0; $i<$this->count_pages; $i++){
			$this->pagination[$i]['PAGE']=($i+1);
			if(($i+1)==$this->page)
			$this->pagination[$i]['SELECTED']=1;
		}
		
	}
	
	
	public function createMember($member){
		return mysql::Insert('members', $member);
	}
	public function updateMember($member){
		return mysql::Update('members', $member);
	}
	public function deleteMember($id){
		
		return mysql::query('DELETE FROM members WHERE id='.(int)$id);
	}
	
	public function returnJsonMembers($page){
		$data = Array();
		$this->loadMembers($page);
		$data['MEMBERS']=$this->getMembers();
		$data['PAGINATION']=$this->getPagination();
		$data['OK']=1;
		return json_encode($data);
	}
	
	public function getMembers(){
		if(sizeof($this->members)>0){
			return $this->members;
		}else{
			return 0;
		}
	}
	public function getPagination(){
		if($this->members_count!=0){
			return $this->pagination;
		}else{
			return 0;
		}
		
	}
	protected function prepareMembers(){
		if(sizeof($this->members)>0){
			foreach($this->members as &$member){
				$member['PRIVATE_VIEW'] = $member['PRIVATE'] == 1 || $member['PRIVATE'] == 'Да' ? 'Да' : 'Нет';
				$member['EMAIL_ORDERS_VIEW'] = $member['EMAIL_ORDERS'] == 1 || $member['EMAIL_ORDERS'] == 'Да' ? 'Да' : 'Нет';
			}
		}else{
			return 0;
		}
	}
}