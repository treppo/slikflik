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

resultsTemplate = '<div id="results"></div>'
$resultsContainer = $(resultsTemplate)
$main = $('main')
$ideasForm = $('#ideas-form')
$suggestionsForm = $('#suggestions-form')
$header = $('#introduction')
suggestionsUrl = $ideasForm.attr 'action'
requestMethod = $ideasForm.attr 'method'

# handle form submission and showing of results
ajaxFormRequest = (ajax, $form, url, method) ->
  ->
    ajax
      url: url
      dataType: 'html'
      type: method
      data: $form.serialize()

showResults = ($container) ->
  (suggestions, status, jqxhr) ->
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


# update browser location when submitting the form
locationConcat = (url, params) ->
  url + '?' + params

leftApply = (func, param1) ->
  (param2) ->
    func param1, param2

nullApplyPushState = (pushState) ->
  (location) ->
    pushState {}, null, location

concatUrl = leftApply locationConcat, suggestionsUrl
pushStateFunc = nullApplyPushState history.pushState.bind history

invokeUpdate = (pushToState, applyUrl, getParams) ->
  (event) ->
    pushToState applyUrl getParams()

$ideasForm.on 'submit', invokeUpdate pushStateFunc, concatUrl, $ideasForm.serialize.bind $ideasForm


# move form on submission
removeVerticalCentering = ($el) ->
  (event) ->
    $el.removeClass 'introduction_vertical_center'

moveForm = removeVerticalCentering $header

$ideasForm.one 'submit', moveForm
