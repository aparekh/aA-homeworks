class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    cups.each_with_index do |cup, idx|
      next if idx == 6 || idx == 13
      4.times do 
        cup << :stone
      end
    end
  end

  def valid_move?(start_pos)
    if !start_pos.between?(0, 13) || (start_pos == 6 || start_pos == 13)
      raise "Invalid starting cup"
    elsif cups[start_pos].empty?
      raise "Starting cup is empty"
    end
  end

  def make_move(start_pos, current_player_name)
    if current_player_name == @name1
      opposing_player_store_pos = 13
    else
      opposing_player_store_pos = 6
    end

    stones = cups[start_pos]
    curr_pos = start_pos

    until stones.empty?
      curr_pos = (curr_pos + 1) % cups.length
      curr_cup = cups[curr_pos]
      
      unless curr_pos == opposing_player_store_pos
        curr_cup << stones.pop
      end
    end

    self.render
    self.next_turn(curr_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if (ending_cup_idx == 6 || ending_cup_idx == 13)
    return :switch if cups[ending_cup_idx].length == 1
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if (0..5).all? { |pos| cups[pos].empty? } || (7..12).all? { |pos| cups[pos].empty? }
    false
  end

  def winner
    player_one_score = cups[6].count
    player_two_score = cups[13].count

    if player_one_score == player_two_score
      return :draw
    else
      player_one_score > player_two_score ? @name1 : @name2
    end
  end
end
