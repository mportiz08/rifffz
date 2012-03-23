initControls = ->
  artist = $('.album-info .artist-name').text()
  album  = $('.album-info .album-name').text()
  songs = _.map $('.album-song-list a'), (s) -> $(s).text()
  controls = new app.Controls(artist, album, songs)

$ ->
  initControls() if $('.album-info').length > 0
