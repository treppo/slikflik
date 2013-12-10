$reference1 = $('#reference1')
$reference2 = $('#reference2')
$movieId1 = $('#movieId1')
$movieId2 = $('#movieId2')

renderTemplate = (suggestion) ->
  """
    <img src="#{suggestion.poster}">
    <p>#{suggestion.title}</p>
  """

typeaheadConfig =
  remote: 'suggestions.json?title=%QUERY'
  valueKey: 'title'
  template: renderTemplate

setIdInputFor = ($input) ->
  (event, suggestion) ->
    $input.val suggestion.id

setup = ($reference, $movieId) ->
  $reference.typeahead typeaheadConfig
  $reference.on 'typeahead:selected', setIdInputFor $movieId

setup $reference1, $movieId1
setup $reference2, $movieId2
$reference1.focus()
