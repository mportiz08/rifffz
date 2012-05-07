$ ->
  $('#library .media-grid a').mouseenter ->
    artist   = $(@).parent().attr 'data-artist'
    album    = $(@).parent().attr 'data-album'
    playlist = $(@).parent().attr 'data-playlist'
    if playlist?
      info = "<strong>#{playlist}</strong>"
    else
      info = "<strong>#{album}</strong> | #{artist}"
    $('.selected-album').html info
  $('#library .media-grid a').mouseleave ->
    $('.selected-album').html ''
