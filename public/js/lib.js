(function() {
  var $ideasForm, $main, $movieId1, $movieId2, $reference1, $reference2, $resultsContainer, formHandler, renderTemplate, requestResults, resultsTemplate, setIdInputFor, setup, showResults, showResultsFromRequest, typeaheadConfig;

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

  resultsTemplate = '<div id="results"></div>';

  $resultsContainer = $(resultsTemplate);

  $main = $('main');

  $ideasForm = $('#ideas-form');

  requestResults = function(ajax, $form) {
    return function() {
      return ajax({
        url: $form.attr('action'),
        dataType: 'html',
        type: $form.attr('method'),
        data: $form.serialize()
      });
    };
  };

  showResults = function($container) {
    return function(suggestions) {
      return $container.html(suggestions);
    };
  };

  showResultsFromRequest = function(asyncRequest, responseHandler) {
    return function(event) {
      event.preventDefault();
      return asyncRequest().done(responseHandler);
    };
  };

  $main.append($resultsContainer);

  formHandler = showResultsFromRequest(requestResults($.ajax, $ideasForm), showResults($resultsContainer));

  $ideasForm.on('submit', formHandler);

}).call(this);

/*
//@ sourceMappingURL=lib.js.map
*/