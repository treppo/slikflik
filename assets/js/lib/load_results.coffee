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
