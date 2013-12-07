(function() {
  var $movieId1, $movieId2, $reference1, $reference2, renderTemplate, setIdInputFor, setup, typeaheadConfig;

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

}).call(this);

/*
//@ sourceMappingURL=lib.js.map
*/