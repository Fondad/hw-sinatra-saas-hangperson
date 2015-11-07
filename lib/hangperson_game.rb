class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  #it processes a guess and modifies the instance variables wrong_guesses and guesses accordingly
  def guess letter
    unless letter =~ /\p{Alpha}/i
      raise ArgumentError
    else
      unless (@guesses+@wrong_guesses).include? letter.downcase
        if @word.include? letter
          @guesses << letter
        else
          @wrong_guesses << letter
        end
        return true
      end
    return false
    end
  end
  
  #it returns one of the symbols :win, :lose, or :play depending on the current game state
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    if self::word_with_guesses == @word 
      return :win
    else 
      return :play
    end
  end
  
  #it substitutes the correct guesses made so far into the word
  def word_with_guesses
    @word.tr("^#{@guesses}.", '-')
    #@word.gsub(/[^@guesses]/, '-')
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
