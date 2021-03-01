class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A"..."Z").to_a.sample
    end
  end

  def is_included?(word, letters)
    valid = true
    word.upcase.split("").each do |letter| 
      if letters.include?(letter)
        a = letters.index(letter)
        letters.delete_at(a)
      else
        valid = false
      end
    end
    valid
  end

  def parsing(parameter)
    url = "https://wagon-dictionary.herokuapp.com/#{parameter}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word]
    @res = parsing(@word)
    @result = ""

    if @res["found"] && is_included?(@word, @letters)
      @result = "Your word is valid"
    elsif !is_included?(@word, @letters)
      @result = "Are you blind? it's not included above"
    else
      @result = "Your word is not valid"
    end
  end
end
