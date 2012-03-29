$ ->
  $('#import-album-modal a.btn.primary').click ->
    $('#import-album-modal form').submit()
    false
  
  source = eval($('#album-path').attr('data-source'))
  $('#album-path').typeahead({source: source})
