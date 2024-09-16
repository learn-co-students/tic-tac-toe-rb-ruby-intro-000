# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board=" ")
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts "-----------"
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts "-----------"
 puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

# how does this work? I know the method "move" takes 3 arguments
# board is from the bin file, index is from input_to_index,
# but index is never specified, player is never speciied either
# *** why is this condition important?
# 'allows "X" player in the bottom right and "O" in the top left'
# *** why must I call the third argument "player"?
# *** if I use "player_token" it fails.
def move(board, index, player)
    board[index] = player
end

# taken from Tic Tac Toe Position Taken
def position_taken?(board,index)
  if (board[index]) == " "
    false
  elsif (board[index]) == ""
    false
  elsif (board[index]) == nil
    false
  elsif (board[index]) == "X" || "O"
    true
  end
end

# taken from acchang/ ttt-7-valid-move-ruby-intro-000
def valid_move?(board, index)
    if !position_taken?(board, index) && index.between?(0, 8)
        return true
      else
        return false
      end
    end

def turn_count(board)
    # counts occupied positions
    counter = 0
    board.each do |space|
    if space == "X" || space == "O"
    counter += 1
      end
    end
        counter
    end

# from Tic Tac Toe Current Player
def current_player(board)
    counter_turn = turn_count(board)
    if counter_turn % 2 == 0
      "X"
    else
      "O"
    end
  end

# from game status
 def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return true
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return true
    end
  end
    return false
end

def full?(board)
    board.all? do |index|
    index == "X" || index == "O"
    end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    end
  end
    return nil
end

# taken from Tic Tac Toe Turn
    def turn(board)
      puts "Please enter 1-9:"
      input=gets.strip
      index = input_to_index(input)
      if valid_move?(board, index) == false
        turn(board)
      else
        move(board, index, current_player(board))
        display_board(board)
      end
    end

def play(board)
    until over?(board)
      turn(board)
      end
    if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
      puts "Cat's Game!"
      end
end

# Run the tests for the #play method by typing rspec spec/02_play_spec.rb in your terminal.
