i = 2
function start () {
	$('.user_box')[0].disabled = true
	$('.movie_box')[0].disabled = true
	$('.user_box')[0].style.background = "salmon"
	$('.movie_box')[0].style.background = "salmon"
}

function activate (element) {
	if ( $('.user_select').is(':checked') ) {
		$(element).parentsUntil('form').last().parent().attr('action', "/admin/bookings/log_by_user")
		$('.user_box')[0].disabled = false
		$('.movie_box')[0].disabled = true
		$('.movie_box')[0].style.background = "salmon"
		$('.user_box')[0].style.background = "firebrick"
		$('.movie_box option:first').attr('selected', 'selected')
	} else {
		if ( $('.movie_select').is(':checked') ) {
			$(element).parentsUntil('form').last().parent().attr('action', "/admin/bookings/log_by_movie")
			$('.movie_box')[0].disabled = false
			$('.user_box')[0].disabled = true
			$('.user_box')[0].style.background = "salmon"
			$('.movie_box')[0].style.background = "firebrick"
			$('.user_box option:first').attr('selected', 'selected')
		}
	}
}

function create_log () {
	form = $('form')
	form.submit()
}

function theatre_log () {
 	form = $('form')
	form.submit()
}

$(document).ready( function () {
	$('#ui-datpicker-div').addClass("hidden")
	$('.show_calender').datepicker({dateFormat : 'dd/mm/yy'})
	//console.log($('select option:first').val())
  	
  })
function get_audis (element) {
	theatre_id = $(element).val()
	 $('#audis').children().each( function() {
		$(this).remove()
	}) 
	if ($(element).val() != "select") {
		$.ajax({
	        url: "/admin/theatres/audis?theatre_id=" + theatre_id,
	        type: 'GET',
	        dataType: 'json',
	        success: function (data) {
	        	for (var i = 0; i < data.length; i++) {
	        		$("#audis").append($("<option value =" + data[i]["id"] + ">" + (i+1) + "</option>"))	
	        	};
	        }
      	});
	} 
}

function show_timing (element) {
	$(element).parent().prepend("<select name = 'showtime[]' onchange = 'hide_default(this)'><option>select</option><option>09:00</option><option>13:00</option><option>18:00</option><option>21:00</option></select>")
	console.log($(element).prev().removeClass("hidden"))
	
	console.log($(element).prev().removeClass("hidden"))
	$(element).addClass("hidden")
	i = i + 1
	i = i + 1
}

function hide_default (element) {
	console.log($(element).children(":first").remove())
}
