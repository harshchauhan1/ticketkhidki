function disable_date () {
 if ($('.movie_box').val() == "select movie" || $('#theatre').val() == "select theatre") {
 	
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