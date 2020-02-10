require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

 def user_word_in_grid?
  @letters = params[:letters]
  @user_word = params[:user_word]
  count_user_word = Hash.new(0)
  count_letters = Hash.new(0)
  @user_word.upcase.split('').each { |key| count_user_word[key] += 1 }
  @letters.split('').each { |key| count_letters[key] += 1 }
  count_user_word.each do |key, value|
    return false if value > count_letters[key]
  end
  return true
 end

 def user_word_english?
  @user_word = params[:user_word]
  url = "https://wagon-dictionary.herokuapp.com/#{@user_word.downcase}"
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)
  end

  def score
    @user_word = params[:user_word]
    @letters = params[:letters]
    return @score = "sorry but #{@user_word} can't be built out of #{@letters}" unless user_word_in_grid?

    return @score = "sorry but #{@user_word} doesn't seems to be a valid English word" unless word[found]

    @score ="congratulation! #{@user_word} is a valid English word"
  end
end
