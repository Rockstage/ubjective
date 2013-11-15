$ ->
  $('#specialty_search').typeahead
    name: "specialty"
    remote: "/specialties/autocomplete?query=%QUERY"