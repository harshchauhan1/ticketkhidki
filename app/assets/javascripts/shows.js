function disable_date () {
console.log($('.movie_box').val())
 if ($('.movie_box').val() == "select movie") {
 	
 	$('.date_box')[0].disabled = true
 }
}

function enable_date () {
	console.log('hello')
 if ($('.movie_box').val() == "select movie") {
 	console.log("in if")
 	$('.date_box')[0].disabled = true
 	$('.date_box option[value="select date"]').attr("selected", "selected");
 }else {
 	$('.date_box')[0].disabled = false
 }
}

function create_shows (element) {
  form = $('form')
  console.log($(element).val())
  //$.get(form.attr('action'), form.serialize(), null, "script")
  if (($(element).val()) != "select date") {
    form.submit()
  }
}

function ticket_book (element) {
  console.log (element)
}
