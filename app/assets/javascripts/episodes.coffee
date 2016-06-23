ready = ->
  $('#jquery_jplayer_1').jPlayer
    ready: ->
      $(this).jPlayer 'setMedia', mp3: $("#episode_content").data("src")
      return
    swfPath: '/js'
    supplied: 'mp3'
  return

$(document).ready(ready)
$(document).on('page:load', ready)