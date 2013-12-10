resultsTemplate = '<div id="results"></div>'
$resultsContainer = $(resultsTemplate)
$main = $('main')
$ideasForm = $('#ideas-form')
$suggestionsForm = $('#suggestions-form')
$header = $('#introduction')
suggestionsUrl = $ideasForm.attr 'action'
requestMethod = $ideasForm.attr 'method'

ajaxFormRequest = (ajax, $form, url, method) ->
  ->
    ajax
      url: url
      dataType: 'html'
      type: method
      data: $form.serialize()

showResults = ($container) ->
  (suggestions) ->
    $container.html suggestions

onAjaxRequestDone = (asyncRequest, responseHandler) ->
  ->
    asyncRequest().done responseHandler

preventDefaultEvent = (func) ->
  (event) ->
    event.preventDefault()
    func()

ideasFormRequest = ajaxFormRequest($.ajax, $ideasForm, suggestionsUrl, requestMethod)
showResultsInContainer = showResults($resultsContainer)

$main.append $resultsContainer
formHandler = preventDefaultEvent onAjaxRequestDone ideasFormRequest, showResultsInContainer

$ideasForm.on 'submit', formHandler


removeVerticalCentering = ($el) ->
  (event) ->
    $el.removeClass 'introduction_vertical_center'

moveForm = removeVerticalCentering $header

$ideasForm.one 'submit', moveForm
