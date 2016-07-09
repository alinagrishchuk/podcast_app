$(document).on 'page:load ready', ->
  $('#search.typeahead').typeahead { highlight: true },
    {
      name: 'podcast',
      source: (query, syncResults, asyncResults) ->
        $.get 'search/autocomplete_podcasts?search=' + query, (data) ->
          asyncResults(data)
    }






