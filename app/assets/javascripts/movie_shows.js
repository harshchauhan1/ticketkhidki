function disable_date () {
 if ($('.movie_box option:first').text() == "select movie" || $('#theatre option:first').text() == "select theatre") {
 	
 	$('.date_box').find("option:first").attr("selected", "selected")
 	$('.date_box')[0].disabled = true
 }
}

function enable_date (element) {

 if ($(element).val() == "select movie" || $(element).val() == "select theatre") {
 	$('.date_box')[0].disabled = true
 	$('.date_box option[value="select date"]').attr("selected", "selected");
 }else {
 	$('.date_box')[0].disabled = false
 }
}

function create_shows (element) {
  form = $('form')
  if (($(element).val()) != "select date") {
    form.submit()
  }
}

function ticket_book (element) {
  
}

$(document).ready( function () {
	$("#theatres").addClass("hidden")
	$("#listing_choice input:first-child").attr("checked", "checked")
	

})

function show_menu(element_to_show, element_to_hide) {
	$("#" + element_to_hide).children().find("option:first").attr("selected", "selected")
	disable_date()
	$("#" + element_to_show).removeClass("hidden")
	$("#" + element_to_hide).addClass("hidden")
}

function update_shows (element) {
	value = $(element).val()
	show_timings = $('.show_time')
	console.log(show_timings[0])
	if (value == 1) {
		$(".highlight").removeClass("highlight")
		show_timings.each( function (index, value) {
			timing = ($(value).text().split(":"))
			class_name = timing[0] + timing[1]
			$(show_timings[index]).addClass(class_name)
			seconds1 = timing[0]*60*60
			seconds = 12*60*60
			if (seconds1 < seconds) {
				required = $("." + class_name)
				$(required).addClass("highlight")
			}
			
		}) 
	}
	if (value == 2) {
		$(".highlight").removeClass("highlight")
		show_timings.each( function (index, value) {
			timing = ($(value).text().split(":"))
			class_name = timing[0] + timing[1]
			$(show_timings[index]).addClass(class_name)
			seconds1 = timing[0]*60*60
			seconds_min = 12*60*60
			seconds_max = 17*60*60	
			if (seconds1 < seconds_max && seconds1 >= seconds_min) {
				required = $("." + class_name)
				console.log(required)
				$(required).addClass("highlight")
			}
			
		}) 
	}
	if (value == 3) {
		$(".highlight").removeClass("highlight")
		show_timings.each( function (index, value) {
			timing = ($(value).text().split(":"))
			class_name = timing[0] + timing[1]
			$(show_timings[index]).addClass(class_name)
			seconds1 = timing[0]*60*60
			seconds_min = 17*60*60	
			if (seconds1 >= seconds_min) {
				required = $("." + class_name)
				console.log(required)
				$(required).addClass("highlight")
			}
			
		}) 
	}
}