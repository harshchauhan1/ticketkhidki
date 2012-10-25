function show_audi_layout ()
{
	$('.hidden').removeClass("hidden")
	$('button')[0].disabled = true
	$('button')[0].style.background = "salmon"
}
function seat_submit () {
	form = $('form')
	comsole.log(form)
	//form.submit()
}
