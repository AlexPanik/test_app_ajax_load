#SKD101|testdb|1|2015.01.19 04:25:38|6|6

DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL DEFAULT '',
  `LOGIN` varchar(100) NOT NULL DEFAULT '',
  `PASSWORD` varchar(100) NOT NULL DEFAULT '',
  `EMAIL` varchar(100) NOT NULL DEFAULT '',
  `ABOUT` text,
  `PRIVATE` tinyint(1) NOT NULL DEFAULT '0',
  `EMAIL_ORDERS` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=36 /*!40101 DEFAULT CHARSET=utf8 */;

INSERT INTO `members` VALUES
(1, 'Administrator', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'webmaster@domain.com', 'Иногда складывается ощущение, что программисты не включают мозги и не пытаются понять, как что работает, а просто следуют простым и понятным правилам вроде «объяви переменную volatile, используй DCL, и всё будет хорошо». К сожалению, такой подход в программировании не всегда работает.', 0, 1),
(2, 'Tester user', 'tester', 'f5d1278e8109edd94e1e4197e04873b9', 'sometestingmail@emailtst.com', 'Разработчик написал volatile, потому что где-то слышал, что так надо, но, видимо, не понял, зачем. По факту публикация объекта TZDB_NAMES_TRIE состоялась в момент volatile-записи: после этого вызовы prepareFind в других потоках будут сразу выходить без синхронизации. При этом после публикации производится множество дополнительных шагов по инициализации.', 0, 0),
(3, 'qwerty', 'qwerty', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'jjjk@hhh.bn', 'Почти половина потоков ничего не нашла, пара потоков вообще упала с исключением. Да, в реальном приложении такое маловероятно, но если сценарий с высокой конкуррентностью авторов не интересует, тогда можно вообще обойтись без volatile и DCL.', 1, 0),
(4, 'Jane', 'janu', '76d80224611fc919a5d54f0ff9fba446', 'z@at.com', 'Тут авторы даже сделали приватный lock-объект для надёжности, но код всё равно сломан. Конечно, может быть ничего страшного не произойдёт, если начать пользоваться myPanels с неустановленным border, но тут проблема серьёзнее: DCL выполняется на одной переменной (myPanels), а инициализируется две (ещё и mySplitters), причём опять же volatile-запись происходит перед полной инициализацией. В результате getMainSplitters() при конкуррентном доступе вполне может вернуть null.', 0, 0),
(5, 'test23', 'test236', '4297f44b13955235245b2497399d7a93', 'hanna.abbath@gmail.com', 'Данный метод используется при поиске часового пояса, и этот поиск вполне можно сломать.', 0, 0),
(35, 'panik', 'panik', 'bca410441b88e24768f3f385548edfbe', 'panik@jj.by', 'no', 1, 1);

