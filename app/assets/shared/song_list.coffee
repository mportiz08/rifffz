setTitle = (name, artist) ->
  title = name
  title = "#{title} ♪ #{artist}" if artist?
  $('title').text title

initControls = (album, songs, artist) ->
  window.controls = new app.Controls(album, songs, artist)

togglePlayShortcut = (e) ->
  e.preventDefault()
  window.controls.togglePlay()

nextTrackShortcut = (e) ->
  e.preventDefault()
  window.controls.nextTrack(e)

prevTrackShortcut = (e) ->
  e.preventDefault()
  window.controls.prevTrack(e)

setupKeyboardShortcuts = ->
  $(document).keypress (e) ->
    togglePlayShortcut(e) if e.which == 32
  $(document).keyup (e) ->
    switch e.which
      when 37, 38 then prevTrackShortcut(e)
      when 39, 40 then nextTrackShortcut(e)

$ ->
  if $('.album-info').length > 0
    artist = $('.album-info .artist-name').text() if $('.artist-name').length > 0
    album  = $('.album-info .album-name').text()
    songs = _.map $('.album-song-list a'), (s) -> $(s).text()
    setTitle(album, artist)
    initControls(album, songs, artist)
    setupKeyboardShortcuts()
