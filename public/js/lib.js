(function() {
  var $header, $ideasForm, $main, $movieId1, $movieId2, $reference1, $reference2, $resultsContainer, $suggestionsForm, ajaxFormRequest, formHandler, ideasFormRequest, moveForm, onAjaxRequestDone, preventDefaultEvent, removeVerticalCentering, renderTemplate, requestMethod, resultsTemplate, setIdInputFor, setup, showResults, showResultsInContainer, suggestionsUrl, typeaheadConfig;

  $reference1 = $('#reference1');

  $reference2 = $('#reference2');

  $movieId1 = $('#movieId1');

  $movieId2 = $('#movieId2');

  renderTemplate = function(suggestion) {
    return "<img src=\"" + suggestion.poster + "\">\n<p>" + suggestion.title + "</p>";
  };

  typeaheadConfig = {
    remote: 'suggestions.json?title=%QUERY',
    valueKey: 'title',
    template: renderTemplate
  };

  setIdInputFor = function($input) {
    return function(event, suggestion) {
      return $input.val(suggestion.id);
    };
  };

  setup = function($reference, $movieId) {
    $reference.typeahead(typeaheadConfig);
    return $reference.on('typeahead:selected', setIdInputFor($movieId));
  };

  setup($reference1, $movieId1);

  setup($reference2, $movieId2);

  $reference1.focus();

  resultsTemplate = '<div id="results"></div>';

  $resultsContainer = $(resultsTemplate);

  $main = $('main');

  $ideasForm = $('#ideas-form');

  $suggestionsForm = $('#suggestions-form');

  $header = $('#introduction');

  suggestionsUrl = $ideasForm.attr('action');

  requestMethod = $ideasForm.attr('method');

  ajaxFormRequest = function(ajax, $form, url, method) {
    return function() {
      return ajax({
        url: url,
        dataType: 'html',
        type: method,
        data: $form.serialize()
      });
    };
  };

  showResults = function($container) {
    return function(suggestions) {
      return $container.html(suggestions);
    };
  };

  onAjaxRequestDone = function(asyncRequest, responseHandler) {
    return function() {
      return asyncRequest().done(responseHandler);
    };
  };

  preventDefaultEvent = function(func) {
    return function(event) {
      event.preventDefault();
      return func();
    };
  };

  ideasFormRequest = ajaxFormRequest($.ajax, $ideasForm, suggestionsUrl, requestMethod);

  showResultsInContainer = showResults($resultsContainer);

  $main.append($resultsContainer);

  formHandler = preventDefaultEvent(onAjaxRequestDone(ideasFormRequest, showResultsInContainer));

  $ideasForm.on('submit', formHandler);

  removeVerticalCentering = function($el) {
    return function(event) {
      return $el.removeClass('introduction_vertical_center');
    };
  };

  moveForm = removeVerticalCentering($header);

  $ideasForm.one('submit', moveForm);

}).call(this);

/*
//@ sourceMappingURL=lib.js.map
*/