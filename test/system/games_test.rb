require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling in a random word returns 'not in the grid'" do
    visit new_url
    fill_in form
    click_on play
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling a letter returns 'not an english word'" do
    visit new_url
    fill_in form
    click_on play
    assert test: "New game"
    assert_selector "li", count: 10
  end
end
