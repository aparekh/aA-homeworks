class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
      system("clear")
    end

    game_over_message
    reset_game
  end

  def take_turn
      show_sequence
      require_sequence

      unless @game_over
        round_success_message
        @sequence_length += 1
      end
  end

  def show_sequence
    add_random_color

    @seq.each do |color|
      puts color
      sleep(3)
      system("clear")
      sleep(1)
    end
  end

  def require_sequence
    count = 0
    correct = true

    puts "Please enter the new sequence, one color at a time."

    until count == sequence_length || game_over == true    
      print ">> "
      color = gets.chomp.downcase
      @game_over = true if color != seq[count]
      count += 1
    end

    sleep(1)
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "Round successful. Here's the next sequence: "
    sleep(2)
  end

  def game_over_message
    puts "Game over! You made it #{@sequence_length - 1} rounds."
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end