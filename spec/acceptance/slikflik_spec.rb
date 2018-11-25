require "spec_helper"
require_relative "application_runner"
require "test_database_connection"

describe "Slik Flik" do
  unforgiven = {id: 33, title: "Unforgiven"}
  good_bad_ugly = {id: 429, title: "The Good, the Bad and the Ugly", year: 1966}
  for_a_few_dollars_more = {id: 938, title: "For a Few Dollars More", year: 1965}
  once_upon_a_time_in_the_west = {id: 335, title: "Once Upon a Time in the West", year: 1968}
  fistful_of_dollars = {id: 391, title: "A Fistful of Dollars", year: 1964}
  oldboy13 = {id: 87516, title: "Oldboy", year: 2013}
  oldboy03 = {id: 670, title: "Oldboy", year: 2003}

  before do
    @app = ApplicationRunner.new
  end

  after do
    TestDatabaseConnection.new.reset
  end

  it "shows results ordered by connection weight" do
    @app.submit_movies for_a_few_dollars_more, once_upon_a_time_in_the_west
    2.times { @app.submit_movies fistful_of_dollars, good_bad_ugly }
    3.times { @app.submit_movies fistful_of_dollars, unforgiven }

    @app.submit_movies once_upon_a_time_in_the_west, fistful_of_dollars

    @app.shows_result_in_order? unforgiven, good_bad_ugly
    @app.shows_result_in_order? good_bad_ugly, for_a_few_dollars_more
  end

  it "shows results without layout for ajax requests" do
    @app.submit_movies for_a_few_dollars_more, once_upon_a_time_in_the_west
    @app.submit_movies fistful_of_dollars, good_bad_ugly

    @app.submit_movies_with_ajax once_upon_a_time_in_the_west, fistful_of_dollars

    @app.shows_result_without_layout? for_a_few_dollars_more
    @app.shows_result_without_layout? good_bad_ugly
  end

  it "shows title suggestions" do
    @app.submit_title "oldboy"

    @app.shows_suggestion? oldboy13
    @app.shows_suggestion? oldboy03
  end

  it "returns title suggestions as json" do
    @app.request_suggestions_as_json "oldboy"

    @app.shows_json_suggestion? oldboy13.merge poster: "http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w92/e8RaZIeFeHpPolSqKGsFVzZRiaE.jpg"
    @app.shows_json_suggestion? oldboy03.merge poster: "http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w92/fct7n9V10E8t8a7wOR90Ccw0i48.jpg"
  end
end
