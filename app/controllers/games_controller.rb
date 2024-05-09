require "open-uri"
class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    @scoring = 0
    word = params[:word]
    @randletters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url)
    word_data = JSON.parse(response.read)

    if !word.each_char.all? { |lettre| @randletters.include?(lettre) }
      @answer = "Sorry but #{word} can't be build out of #{@randletters}} "
    elsif !word_data['found']
      @answer = "Sorry but #{word} is not an English word"
    else
      @answer = "Congratulation #{word} is a real word"
      @scoring += word.length
    end
  end


end
