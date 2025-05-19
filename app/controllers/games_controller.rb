require 'open-uri'
require 'json'

class GamesController < ApplicationController



def new
  @letters = [*('A'..'Z')].sample(10)
  @letters_display = @letters.join
end

def score
@letters = params[:letters].downcase
@answer = params[:answer].downcase
@answer_split = @answer.chars
@letters_array = @letters.chars

@grid_valid = @answer_split.all? { |i| @answer_split.count(i) <= @letters_array.count(i) }

url = "https://dictionary.lewagon.com/#{@answer}"
attempt_serialized = URI.parse(url).read
api = JSON.parse(attempt_serialized)
@english_valid = api["found"]
@score = 0
@result = "Your word can't be built with the given letters"
      if @grid_valid && @english_valid
        @result = "Congratulation!"
        @score = @answer.length
      elsif @grid_valid
        @result =  "This is not an english word"
      end

end


end
