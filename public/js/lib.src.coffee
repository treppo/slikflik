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

resultsTemplate = '<div id="results"></div>'
$resultsContainer = $(resultsTemplate)
$main = $('main')
$ideasForm = $('#ideas-form')

requestResults = (ajax, $form) ->
  ->
    ajax
      url: $form.attr 'action'
      dataType: 'html'
      type: $form.attr 'method'
      data: $form.serialize()

showResults = ($container) ->
  (suggestions) ->
    $container.html suggestions

showResultsFromRequest = (asyncRequest, responseHandler)->
  (event) ->
    event.preventDefault()
    asyncRequest().done responseHandler

$main.append $resultsContainer
formHandler = showResultsFromRequest(requestResults($.ajax, $ideasForm), showResults($resultsContainer))
$ideasForm.on 'submit', formHandler
