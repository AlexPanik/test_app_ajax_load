var tek_elem;
var page=1;
function updateData(data){
	/*тут вставляю новые данные в табличку и пэйджинг*/
	var data = $.parseJSON(data);
	var members = data.MEMBERS;
	var pagination = data.PAGINATION;
	if(data.OK=="1"){
		$('.members_data').remove();
		for (index = 0; index < members.length; ++index) {
			$('#table_members').append('<tr attr_id="'+members[index]['ID']+'" class="members_data"><td>'+members[index]['NAME']+'</td><td>'+members[index]['LOGIN']+'</td><td>'+members[index]['EMAIL']+'</td><td>'+members[index]['ABOUT']+'</td><td>'+members[index]['PRIVATE_VIEW']+'</td><td>'+members[index]['EMAIL_ORDERS_VIEW']+'</td><td><div class="btn btn-info glyphicon glyphicon-pencil member_form" href="#member_edit"></div> <div class="btn btn-danger glyphicon glyphicon-remove"></div></td></tr>');
		}
		$('.pagination').html('');
		for (index = 0; index < pagination.length; ++index) {
			
			if(pagination[index]['SELECTED']=="1")
			$('.pagination').append('<li class="active"><a class="page_load">'+pagination[index]['PAGE']+'</a></li>');
			else
			$('.pagination').append('<li><a class="page_load">'+pagination[index]['PAGE']+'</a></li>');
		}
	}else{
		alert('Не получилось загрузить данные');
	}
	autoLoad();
}

function autoLoad(){
	/*т.к. используется аякс буду перевызывать слушателей (как выриант можно было переделать под onclick, но мне так не нравится)*/
	$(".glyphicon-pencil").click(function() {
		/*заганяем данные в форму для редакирования - как вариант данные можно было брать из загруженного json*/
		$('#member_edit_form').trigger('reset')
		$('#member_edit input[name="NAME"]').val($(this).parent().parent().find('td:eq(0)').text());
		$('#member_edit input[name="LOGIN"]').val($(this).parent().parent().find('td:eq(1)').text());
		$('#member_edit input[name="PASSWORD"]').val('');
		$('#member_edit input[name="EMAIL"]').val($(this).parent().parent().find('td:eq(2)').text());
		$('#member_edit input[name="ID"]').val($(this).parent().parent().attr('attr_id'));
		$('#edit_about').val($(this).parent().parent().find('td:eq(3)').text());
		if($(this).parent().parent().find('td:eq(4)').text()=='Да'){
			$('#member_edit input[name="PRIVATE"]').click();
		}
		if($(this).parent().parent().find('td:eq(5)').text()=='Да'){
			$('#member_edit input[name="EMAIL_ORDERS"]').click();
		}
	});
	
	$(".page_load").click(function() {
		/*переход по страницам*/
		$(".page_load").parent().removeClass('active');
		$(this).parent().addClass('active');
		page=$(this).text();
		$("#refr_members").click();
	});
	$(".glyphicon-remove").click(function() {
		/*удаление записи*/
		tek_elem=this;
		
		if(confirm('Действительно удалить запись?')){
			$.post( "json.php", { mode:"delete_member", id: $(this).parent().parent().attr('attr_id'), page: page}).done(function( data ) {
				if( data!="0") {
					updateData(data);
				}
			});
		}
	});
}

$( document ).ready(function() {
	$( "#but_search" ).click(function() {
		var input_search_select=$('#input_search_select').val();
		var input_search_text=$('#input_search_text').val();
		
		$.post( "json.php", { mode:"search_members", input_search_select:input_search_select, input_search_text:input_search_text, page: page}).done(function( data ) {
			updateData(data);
		});
	});
	$(".sort_field").click(function() {
		$('.sort_field').removeClass('act');
			$(this).addClass('act');
		$.post( "json.php", { mode:"sort_members", sort_by:$(this).attr('attr_name'), page: page}).done(function( data ) {
			
			updateData(data);
		});
		
	});
	$( "#add_member" ).click(function() {
		var name=$('#member_add input[name="NAME"]').val();
		var login=$('#member_add input[name="LOGIN"]').val();
		var password=$('#member_add input[name="PASSWORD"]').val();
		var email=$('#member_add input[name="EMAIL"]').val();
		var about=$('#add_about').val();
		if($('#member_add input[name="PRIVATE"]:checked').val()==1){
			var private_per=1;
		}else{
			var private_per=0;
		}
		if($('#member_add input[name="EMAIL_ORDERS"]:checked').val()==1){
			var email_orders=1;
		}else{
			var email_orders=0;
		}
		$.post( "json.php", { mode:"add_member", name: name, login: login, password: password, email: email, about: about, private_per: private_per,  email_orders: email_orders, page: page}).done(function( data ) {
			if( data!="0"){
				updateData(data);
				$('#member_add_form').trigger('reset')
				$.fancybox.close();
				
			}
		});
    });
	$( "#edit_member" ).click(function() {
		var name=$('#member_edit input[name="NAME"]').val();
		var login=$('#member_edit input[name="LOGIN"]').val();
		var password=$('#member_edit input[name="PASSWORD"]').val();
		var email=$('#member_edit input[name="EMAIL"]').val();
		var about=$('#edit_about').val();
		var id=$('#member_edit input[name="ID"]').val();
		if($('#member_edit input[name="PRIVATE"]:checked').val()==1){
			var private_per=1;
		}else{
			var private_per=0;
		}
		if($('#member_edit input[name="EMAIL_ORDERS"]:checked').val()==1){
			var email_orders=1;
		}else{
			var email_orders=0;
		}
		$.post( "json.php", { mode:"update_member", id: id, name: name, login: login, password: password, email: email, about: about, private_per: private_per,  email_orders: email_orders, page: page}).done(function( data ) {
			if( data!="0"){
				updateData(data);
				$('#member_edit_form').trigger('reset')
				$.fancybox.close();
			}
		});
    });
	
	$("#refr_members").click(function() {
		$.post( "json.php", { mode:"update_members", page: page}).done(function( data ) {
			updateData(data);
		});
	});
	
	
	autoLoad();
});
$(document).ready(function() {
	$(".member_form").fancybox({
		maxWidth	: 400,
		minHeight	: 580,
		fitToView	: false,
		width		: '70%',
		height		: '70%',
		autoSize	: false,
		closeClick	: false,
		openEffect	: 'none',
		closeEffect	: 'none'
	});
});