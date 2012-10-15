function create_shows (element) {
  form = $('form')
  console.log(form.attr('action'))
  //$.get(form.attr('action'), form.serialize(), null, "script")
    form.submit()
}

function ticket_book (element) {
  console.log (element)
}
