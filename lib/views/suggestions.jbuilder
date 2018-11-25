json.array! suggestions do |suggestion|
  json.poster poster_url.small + suggestion.poster_path if suggestion.poster_path
  json.title "#{suggestion.title} (#{suggestion.year})"
  json.id suggestion.id
end
