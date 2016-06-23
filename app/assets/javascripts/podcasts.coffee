$(document).on 'page:load', ->
  console.log('ajax fire')
  $('#links a').on 'ajax:complete', ->
    $('#links a').removeClass('active')
    $(this).addClass('active')
