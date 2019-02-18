require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:grid].split
    @result = calculate_score(@word, @letters)
    @score = session[:score]
  end

  private

  def calculate_score(word, letters)
    session[:score] = 0 unless session[:score]
    if in_grid?(word, letters)
      if english_word?(word)
        session[:score] += word.length
        'success'
      else 'not english'
      end
    else
      'not in grid'
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(open(url).read)['found']
  end

  def in_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
