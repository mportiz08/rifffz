$ ->
  $('#library .media-grid a').mouseenter ->
    artist = $(@).parent().attr 'data-artist'
    album  = $(@).parent().attr 'data-album'
    $('#library').after "<div id=\"selected-album\"><h1>#{album} <small>#{artist}</small></h1></div>"
  $('#library .media-grid a').mouseleave ->
    $('#selected-album').remove()
