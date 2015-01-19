<?php
/*
* MySQL database class
*
* Used by all modules to work with MySQL database
*
* @author Alex Ponomarenko <alex25853@gmail.com>
*/

class mysql{
	protected static $_instance;  
	public static function getInstance() { 
		if (self::$_instance === null) {
			self::$_instance = new self;  
		}
		return self::$_instance;
	}
	private  function __construct() {
			$this->connect = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD) or die("Невозможно установить соединение".mysql_error());
			mysql_select_db(DB_NAME, $this->connect) or die ("Невозможно выбрать указанную базу".mysql_error());
			$this->query('SET names "utf8"');  
			$this->query("SET CHARACTER SET 'utf8';");
	}


	public static function query($sql) {
		$obj=self::$_instance;
		
		if(isset($obj->connect)){
			$obj->count_sql++;
			$start_time_sql = microtime(true);
			$result=mysql_query($sql)or die("<br/><span style='color:red'>Ошибка в SQL запросе:</span> ".mysql_error());
			$time_sql = microtime(true) - $start_time_sql;
			if(DBG=="1")
			echo "<br/><br/><span style='color:blue'> <span style='color:green'># Запрос номер ".$obj->count_sql.": </span>".$sql."</span> <span style='color:green'>(".round($time_sql,4)." msec )</span>";            
			return $result;
		}
		return false;
	}  
	
	public static function Select($query) {
        $result=self::query($query);
        $res=array();
		for($i=0;$i<mysql_num_rows($result);$i++) {
			$rec=mysql_fetch_array($result, MYSQL_ASSOC);
			$res[]=$rec;
		}
		return $res;
	}
	
	public static function SelectOne($query) {
		$result=self::query($query);
		$rec=mysql_fetch_array($result, MYSQL_ASSOC);
		return $rec;
	}
	
	public static function Update($table, $data, $ndx="ID") {
		$query="UPDATE `$table` SET ";
		foreach($data as $field=>$value) {
			if (!is_Numeric($field)) {
				$query.="`$field`='".self::DBSafe($value)."', ";
			}
		}
		$query=substr($query, 0, strlen($query)-2);
		$query.=" WHERE $ndx='".$data[$ndx]."'";
		self::query($query);
		return 1;
	}
	
	public function Insert($table, &$data) {
        $fields="";
        $values="";
        foreach($data as $field=>$value) {
			if (!is_Numeric($field)) {
				$fields.="`$field`, ";
				$values.="'".self::DBSafe($value)."', ";
			}
        }
        $fields=substr($fields, 0, strlen($fields)-2);
        $values=substr($values, 0, strlen($values)-2);
		
        $query="INSERT INTO `$table`($fields) VALUES($values)";
        self::query($query);
        return self::insert_id();
	}

	public static function DbSafe($str) {
		$str=mysql_real_escape_string($str);
		#$str=str_replace("%", "\%", $str);
		return $str;
	}
	public static function insert_id() {
		return @mysql_insert_id();
	}
}