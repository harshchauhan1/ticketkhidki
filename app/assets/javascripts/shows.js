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
