ready = ->
  $('.pagination > a').attr('data-remote', 'true')

  $(document).on 'ajax:beforeSend', ->
    $(".loader_container").css('display','block')

  $(document).on 'ajaxComplete', (evt, data, status, xhr) ->
    $(".loader_container").css('display','none')

$(document).ready(ready)
$(document).on('page:load', ready)