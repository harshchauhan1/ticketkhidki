function start () {
	$('.user_box')[0].disabled = true
	$('.movie_box')[0].disabled = true
	$('.user_box')[0].style.background = "salmon"
	$('.movie_box')[0].style.background = "salmon"
}

function activate () {
	console.log ('hello')
	if ( $('.user_select').is(':checked') ) {
		$('.user_box')[0].disabled = false
		$('.movie_box')[0].disabled = true
		$('.movie_box')[0].style.background = "salmon"
		$('.user_box')[0].style.background = "firebrick"
		$('.movie_box').attr('value', 'select movie')
	} else {
		if ( $('.movie_select').is(':checked') ) {
			$('.movie_box')[0].disabled = false
			$('.user_box')[0].disabled = true
			$('.user_box')[0].style.background = "salmon"
			$('.movie_box')[0].style.background = "firebrick"
			$('.user_box').attr('value', 'select user')
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
  	
  })


function get_audis (element) {
	theatre_id = $(element).val()
	 $('#hhh').children().each( function() {
		$(this).remove()
	}) 
	if ($(element).val() != "select") {
		$.ajax({
	        url: "/theatres/audis?theatre_id=" + theatre_id,
	        type: 'GET',
	        dataType: 'json',
	        success: function (data) {
	        	for (var i = 0; i < data.length; i++) {
	        		$("#hhh").append($("<option>" + data[i]["id"] + "</option>"))	
	        	};
	        }
      	});
	} 
}

function show_timing (element) {
	console.log($(element).prev().removeClass("hidden"))
	$(element).addClass("hidden")
}

function hide_default (element) {
	console.log($(element).children(":first").remove())
}