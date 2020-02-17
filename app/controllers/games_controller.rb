require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join(' ')
  end

  def score
    @answer = params[:word]

    response = open("https://wagon-dictionary.herokuapp.com/#{@answer.downcase}")
    attempt = JSON.parse(response.read.to_s)

    if @answer.split("").all? { |letter| params[:letters].include? letter } && attempt['found']
      @message = "Congratulations! #{@answer.capitalize} is an english word"

    elsif @answer.split("").all? { |letter| params[:letters].include? letter } && !attempt['found']
      @message = "Im sorry, #{@answer.capitalize} does not seem to be a valid english word"
    else
      @message = "Im sorry, #{@answer.capitalize} cannot be built out of the letters"
    end
  end
end
