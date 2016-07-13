$(document).on 'page:fetch ajax:beforeSend', ->
  loaderSplashScreen.show()

$(document).on 'page:update', ->
  setPagingRemote()
  loaderSplashScreen.hide()
  displayInputFileName.init()

# set ajax call for paging on the page (will_paginate gem)
setPagingRemote = ->
  $('.pagination > a').attr('data-remote', 'true')

#show input file name (using CustomFormBuilder#file_field_button)
displayInputFileName =
  init: ->
    $('input[type=file]').on 'change', (event) ->
      fileName = 'not selected'
      files = event.target.files
      if files[0]
        fileName = files[0].name.substring(0,50);
      $(this).parent().next(".file-name").text(fileName)

loaderSplashScreen = {
  show: ->
    $(".loader_container").css('display','block')

  hide: ->
    $(".loader_container").css('display','none')
}










