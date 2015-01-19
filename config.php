<?php
@session_start();
ini_set('display_errors', false);


Define('DB_HOST', 'localhost');
Define('DB_NAME', 'testdb');
Define('DB_USER', 'root');
Define('DB_PASSWORD', '');
Define('DBG', '0'); /*особо не нужна - иcпользовал для отображение mysql запросов*/
Define('PER_PAGE', '3');

define('CURRENT_TIME', time() );
define('ROOT_DIR', dirname(__FILE__)."/");
define('LIB_DIR', ROOT_DIR."lib/" );
define('C_DIR', ROOT_DIR."c/" );
define('MODULES_DIR', ROOT_DIR."modules/" );
define('FUNCTIONS_DIR', ROOT_DIR."functions/" );
define('TEMPLATES_DIR', ROOT_DIR."tpl/" );

require_once(C_DIR.'members.class.php');
require_once(FUNCTIONS_DIR . "xss.php");
require_once(LIB_DIR . "mysql.class.php");
require_once(LIB_DIR . "meta.class.php");
?>