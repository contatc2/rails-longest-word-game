require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    result = params[:word].upcase
    letters = params[:grid].split
    @score = if in_grid?(result, letters)
               if english_word?(result)
                 "Congratulations! #{result} is valid according to the grid and is an English word!"
               else
                 "#{result} is valid according to the grid, but is not a valid English word"
               end
             else
               "Sorry #{result} can't be built out of #{params[:grid]}..."
             end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(open(url).read)['found']
  end

  def in_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
