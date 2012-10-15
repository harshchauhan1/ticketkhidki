function render_shows(element) {
	console.log($(element).closest('form'));
	form = $(element).closest('form')
	console.log(form.attr('action'))
	$.get(form.attr('action'), form.serialize(), null, "script")
    form.submit()
}
