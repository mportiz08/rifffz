$ ->
  $('#import-album-modal a.btn.primary').click ->
    $('#import-album-modal form.import-album').submit()
    false
  
  source = ($(el).val() for el in $('form.autocomplete input[type="hidden"]'))
  $('#album-path').typeahead({source: source})
