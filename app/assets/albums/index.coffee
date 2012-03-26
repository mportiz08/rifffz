$ ->
  $('#library .media-grid a').mouseenter ->
    artist = $(@).parent().attr 'data-artist'
    album  = $(@).parent().attr 'data-album'
    $('.selected-album').html "<strong>#{album}</strong> | #{artist}"
  $('#library .media-grid a').mouseleave ->
    $('.selected-album').html ''
