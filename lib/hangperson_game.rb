class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)    
    raise ArgumentError unless letter =~ /[A-Za-z]/

    letter.downcase!
    if self.guesses.include? letter or self.wrong_guesses.include? letter
      return false
    end
    if self.word.include? letter
      self.guesses << letter
    else
      self.wrong_guesses << letter
    end
    return true
  end

  def word_with_guesses
    self.word.chars.map { |c| (self.guesses.include? c) ? c : '-' }.join
  end

  def check_win_or_lose
    if !self.word_with_guesses.include? '-'
      :win
    elsif self.word_with_guesses.include? '-' and self.wrong_guesses.length == 7
      :lose
    else
      :play
    end
  end

end
