$(document).on 'ajax:beforeSend', ->
  loaderSplashScreen.show()
$(document).on 'page:fetch', ->
  loaderSplashScreen.show()

$(document).on 'page:update', ->
  setPagingRemote()
  loaderSplashScreen.hide()

# set ajax call for paging on the page (will_paginate gem)
setPagingRemote = ->
  $('.pagination > a').attr('data-remote', 'true')

loaderSplashScreen = {
  show: ->
    $(".loader_container").css('display','block')

  hide: ->
    $(".loader_container").css('display','none')
}
