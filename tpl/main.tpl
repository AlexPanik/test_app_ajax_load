
<div class="member_form btn btn-default " href="#member_add">
	<span class="glyphicon glyphicon-plus" ></span> Добавить запись
</div>
<div class="btn btn-default " id="refr_members" >
	<span class="glyphicon glyphicon-refresh" ></span> Обновить данные
</div>
<br>
<br>

<form class="form-inline">
  <div class="form-group">
	
    <p class="form-control-static">Фильтр:</p>
  </div>
  <div class="form-group">
    <label for="input_search_select" class="sr-only">Password</label>
	<select id="input_search_select" class="form-control">
		<option <?php if($out['search_by']=='NAME') echo 'selected'; ?> value="NAME">Имя</option>
		<option <?php if($out['search_by']=='LOGIN') echo 'selected'; ?> value="LOGIN">Логин</option>
		<option <?php if($out['search_by']=='EMAIL') echo 'selected'; ?> value="EMAIL">E-mail</option>
		<option <?php if($out['search_by']=='ABOUT') echo 'selected'; ?> value="ABOUT">Биография</option>
		<option <?php if($out['search_by']=='PRIVATE') echo 'selected'; ?> value="PRIVATE">Приватный</option>
		<option <?php if($out['search_by']=='EMAIL_ORDERS') echo 'selected'; ?> value="EMAIL_ORDERS">Отправлять письма</option>
	</select>
  </div>
  <div class="form-group">
    <label for="input_search_text" class="sr-only">Текст для поиска</label>
    <input type="text" value="<?=$out['search_text'];?>" class="form-control" id="input_search_text" placeholder="Текст для поиска">
  </div>
  <div id="but_search" class="btn btn-default">Искать</div>
</form>
<br>
<br>
<table class="table table-bordered table-striped" id="table_members">
<tr>
	<th><a class="sort_field <?php if($out['sort_by']=='NAME') echo 'act'; ?>" attr_name="NAME">Имя</a></th>
	<th><a class="sort_field <?php if($out['sort_by']=='LOGIN') echo 'act'; ?>" attr_name="LOGIN">Логин</a></th>
	<th><a class="sort_field <?php if($out['sort_by']=='EMAIL') echo 'act'; ?>" attr_name="EMAIL">E-mail</a></th>
	<th><a class="sort_field <?php if($out['sort_by']=='ABOUT') echo 'act'; ?>" attr_name="ABOUT">Биография</a></th>
	<th><a class="sort_field <?php if($out['sort_by']=='PRIVATE') echo 'act'; ?>" attr_name="PRIVATE">Приватный</a></th>
	<th><a class="sort_field <?php if($out['sort_by']=='EMAIL_ORDERS') echo 'act'; ?>" attr_name="EMAIL_ORDERS">Отправлять письма</a></th>
	<th>Управление</th>
</tr>
<?php foreach($out['users'] as $user): ?>
<tr attr_id="<?=$user['ID'];?>" class="members_data">
	<td><?=$user['NAME'];?></td>
	<td><?=$user['LOGIN'];?></td>
	<td><?=$user['EMAIL'];?></td>
	<td><?=$user['ABOUT'];?></td>
	<td><?=$user['PRIVATE_VIEW'];?></td>
	<td><?=$user['EMAIL_ORDERS_VIEW'];?></td>
	<td>
		<div class="btn btn-info glyphicon glyphicon-pencil member_form" href="#member_edit"></div>
		<div class="btn btn-danger glyphicon glyphicon-remove"></div>
	</td>
</tr>
<?php endforeach; ?>
</table>
<nav>
  <ul class="pagination">
	<?php foreach($out['pagination'] as $page): ?>
	<?php if($page['PREV']): ?>
	
	<?php elseif($page['NEXT']): ?>
	
	<?php else: ?>
	 <li <?php if($page['SELECTED']): ?>class="active"<?php endif; ?>><a class="page_load"><?=$page['PAGE'];?></a></li>
	<?php endif; ?>
	<?php endforeach; ?>
   
    
  </ul>
</nav>
<div style="display:none">
	<div id="member_add">
		<form id="member_add_form">
			<h2>Добавление пользователя</h2>
			<div class="form-group ">
				<label for="add_name">Имя</label>
				<input type="text" name="NAME" class="form-control" id="add_name" placeholder="Введите имя">
			</div>
			<div class="form-group">
				<label for="add_login">Логин</label>
				<input type="text" name="LOGIN" class="form-control" id="add_login" placeholder="Введите логин">
			</div>
			<div class="form-group">
				<label for="add_pass">Пароль</label>
				<input type="password" name="PASSWORD" class="form-control" id="add_pass" placeholder="Введите пароль">
			</div>
			<div class="form-group">
				<label for="add_email">E-mail</label>
				<input type="text" name="EMAIL" class="form-control" id="add_email" placeholder="Введите email">
			</div>
			<div class="form-group">
				<label for="add_about">Биография</label>
				<textarea name="ABOUT" class="form-control" id="add_about" placeholder="Заполните биографию"></textarea>
			</div>
			<div class="checkbox">
				<label>
				  <input type="checkbox" name="PRIVATE" value="1"> Приватный?
				</label>
			</div>
			<div class="checkbox">
				<label>
				  <input type="checkbox" name="EMAIL_ORDERS" value="1"> Получать письма?
				</label>
			</div>
			<button type="button" class="btn btn-success" id="add_member">Принять</button>
			<button type="button" class="btn btn-default" onclick="$.fancybox.close();">Отменить</button>
		</form>
	</div>
	<div id="member_edit">
		<form id="member_edit_form">
			<h2>Редактирование пользователей</h2>
			<div class="form-group ">
				<label for="edit_name">Имя</label>
				<input type="text" name="NAME" class="form-control" id="edit_name" placeholder="Введите имя">
			</div>
			<div class="form-group">
				<label for="edit_login">Логин</label>
				<input type="text" name="LOGIN" class="form-control" id="edit_login" placeholder="Введите логин">
			</div>
			<div class="form-group">
				<label for="edit_pass">Пароль</label>
				<input type="password" name="PASSWORD" class="form-control" id="edit_pass" placeholder="Введите пароль">
			</div>
			<div class="form-group">
				<label for="edit_email">E-mail</label>
				<input type="text" name="EMAIL" class="form-control" id="edit_email" placeholder="Введите email">
			</div>
			<div class="form-group">
				<label for="edit_about">Биография</label>
				<textarea name="ABOUT" class="form-control" id="edit_about" placeholder="Заполните биографию"></textarea>
			</div>
			<div class="checkbox">
				<label>
				  <input type="checkbox" name="PRIVATE" value="1"> Приватный?
				</label>
			</div>
			<div class="checkbox">
				<label>
				  <input type="checkbox" name="EMAIL_ORDERS" value="1"> Получать письма?
				</label>
			</div>
			<input type="hidden" name="ID">
			<button type="button" class="btn btn-success" id="edit_member">Принять</button>
			<button type="button" class="btn btn-default" onclick="$.fancybox.close();">Отменить</button>
		</form>
	</div>
</div>