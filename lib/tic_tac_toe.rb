WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

#-------------------------------------------------------------------

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#-------------------------------------------------------------------

def input_to_index(user_input)
  user_input.to_i - 1
end

#-------------------------------------------------------------------

def move(board, index, token)
  board[index] = token
end

#-------------------------------------------------------------------

def position_taken?(board, index)
  if (board[index] == "" || board[index] == " " || board[index] == nil)
    return false
  else
    return true
  end
end

#-------------------------------------------------------------------

def valid_move?(board, index)
  if index.between?(0, 9) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

#-------------------------------------------------------------------

def turn(board)
  puts "Please choose a number 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

#-------------------------------------------------------------------

def turn_count(board)
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  return turns
end

#-------------------------------------------------------------------

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#-------------------------------------------------------------------

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

#-------------------------------------------------------------------

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

#-------------------------------------------------------------------

def draw?(board)
  full?(board) && !won?(board)
end

#-------------------------------------------------------------------

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

#-------------------------------------------------------------------

def winner (board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

#-------------------------------------------------------------------

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
