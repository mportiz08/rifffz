class app.Controls
  constructor: (@artist, @album, @songs) ->    
    @playPauseEl  = $('.play-pause')
    @prevTrackEl  = $('.prev-track')
    @nextTrackEl  = $('.next-track')
    @progressEl   = $('.progress-bar span')
    @timePassedEl = $('.time-passed')
    @timeTotalEl  = $('.time-total')
    @songListEl   = $('.album-song-list')
    
    @audio = $('audio').get 0
    $(@audio).bind 'canplay', @initDuration
    $(@audio).bind 'timeupdate', @updateProgress
    $(@audio).bind 'ended', @nextTrack
    
    @playPauseEl.click @togglePlay
    @prevTrackEl.click @prevTrack
    @nextTrackEl.click @nextTrack
    $('.progress-bar a').click @seek
    @songListEl.on 'click', 'li a', @clickTrack

  initDuration: =>
    duration = parseInt(@audio.duration, 10)
    durationMins = Math.floor (duration / 60), 10
    durationSecs = duration - (durationMins * 60)
    padding = ''
    padding = '0' if durationSecs < 10
    @timeTotalEl.text(durationMins + ':' + padding + durationSecs)

  updateProgress: =>
    @updateProgressBar()
    @updateTimePassed()

  updateProgressBar: ->    
    percentage = (@audio.currentTime / @audio.duration) * 100
    @progressEl.css(width: percentage + '%')

  updateTimePassed: ->
    timePassed = parseInt(@audio.currentTime, 10)
    timePassedMins = Math.floor (timePassed / 60), 10
    timePassedSecs = timePassed - (timePassedMins * 60)
    padding = ''
    padding = '0' if timePassedSecs < 10
    @timePassedEl.text(timePassedMins + ':' + padding + timePassedSecs)

  togglePlay: =>
    if @audio.paused
      @audio.play()
      @setPauseIcon()
      @sendNotification()
    else
      @audio.pause()
      @setPlayIcon()
    false
  
  sendNotification: ->
    song = $('.now-playing').attr('data-song-slug')
    $.post '/songs/play',
      artist: app.Util.slugify(@artist),
      album: app.Util.slugify(@album),
      song: song,

  setPauseIcon: ->
    @playPauseEl.removeClass 'sprite-icons-Play'
    @playPauseEl.addClass 'sprite-icons-Pause'

  setPlayIcon: ->
    @playPauseEl.removeClass 'sprite-icons-Pause'
    @playPauseEl.addClass 'sprite-icons-Play'
  
  clickTrack: (event) =>
    trackNo = $(event.target).parent().prevAll().length
    @changeTrack trackNo
    false
  
  prevTrack: (event) =>
    trackNo = $('.now-playing').prevAll().length - 1
    @changeTrack trackNo unless trackNo < 0
    false
  
  nextTrack: (event) =>
    trackNo = $('.now-playing').prevAll().length + 1
    if trackNo > (@songs.length - 1)
      @albumOver()
    else
      @changeTrack trackNo
    false
  
  albumOver: ->
    @setPlayIcon()
    $('.progress-bar span').css
      width: '0%'
    @timePassedEl.text '0:00'

  changeTrack: (trackNo) ->
    @updateNowPlaying trackNo
    $('audio').attr 'src', "/#{app.Util.slugify @artist}/#{app.Util.slugify @album}/#{app.Util.slugify @songs[trackNo]}/audio"
    @togglePlay()
    @updateProgress()
  
  updateNowPlaying: (trackNo) ->
    trackEl = @songListEl.find('li').eq trackNo
    $('.now-playing .label').remove()
    $('.now-playing').removeClass 'now-playing'
    $(trackEl).addClass 'now-playing'
    $(trackEl).html "<span class=\"label success\">now playing</span> #{trackEl.html()}"
  
  seek: (event) =>
    el = $('.progress-bar')
    x = event.pageX - el.offset().left
    pct = x / el.width()
    duration = parseInt(@audio.duration, 10)
    @audio.currentTime = pct * duration
    false
