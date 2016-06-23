$(document).on 'page:load', ->
  $('#links a').on 'ajax:complete', ->
    $('#links a').removeClass('active')
    $(this).addClass('active')
