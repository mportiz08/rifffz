addSongToPlaylist = (song) ->
  $('.playlist-empty').detach()
  html = """
  <div class="row playlist-item">
    <div class="span10 playlist-item-info">
      <h2>#{song.title}</h2>
      <h3>#{song.album.artist.name}</h3>
    </div>
    <div class="span6 playlist-item-album">
      <img src="#{song.album.thumbnail}" width="128" height="128" alt="#{song.album.title}" />
    </div>
  </div>
  """
  params = """
  <input type="hidden" name="playlist-songs[]" value=#{song.id} />
  """
  $('form.playlist-info').append params
  $('.playlist-contents').append html

fetchSongFromApi = ->
  autocomplete_vals = $('#playlist-add-song').val().split('|')
  song   = app.Util.slugify $.trim(autocomplete_vals[0])
  album  = app.Util.slugify $.trim(autocomplete_vals[1])
  artist = app.Util.slugify $.trim(autocomplete_vals[2])
  $.getJSON "/#{artist}/#{album}/#{song}.json", (data) ->
    addSongToPlaylist data.song
    $('#playlist-add-song').val ''
  false

$ ->
  autocomplete_songs = ($(el).val() for el in $('form.autocomplete input[type="hidden"]'))
  $('#playlist-add-song').typeahead({source: autocomplete_songs})
  $('#playlist-add-song-btn').click fetchSongFromApi
