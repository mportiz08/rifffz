setTitle = (artist, album) ->
  $('title').text "♪ #{album} | #{artist}"

initControls = (artist, album, songs) ->
  controls = new app.Controls(artist, album, songs)

$ ->
  if $('.album-info').length > 0
    artist = $('.album-info .artist-name').text()
    album  = $('.album-info .album-name').text()
    songs = _.map $('.album-song-list a'), (s) -> $(s).text()
    setTitle(artist, album)
    initControls(artist, album, songs)
