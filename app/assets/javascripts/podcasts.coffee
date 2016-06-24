ready = ->
  $('#links a').on 'ajax:complete', ->
    $('#links a').removeClass('active')
    $(this).addClass('active')

$(document).ready(ready)
$(document).on('page:load', ready)


