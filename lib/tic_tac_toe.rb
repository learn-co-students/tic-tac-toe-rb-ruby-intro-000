WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  elsif board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && (board[index] == " " || board[index] == "")
    true
  elsif board[index] == "X" || board[index] == "O"
    return false
  end
end

def current_player(board)
  turns_played = turn_count(board)
  if turns_played % 2 == 0
    current_player = "X"
  elsif turns_played % 2 == 1
    current_player = "O"
  end
end

def turn_count(board)
  num_turns = 0
  board.each do |space|
    if "#{space}" == "X" || "#{space}" == "O"
      num_turns += 1
    end
  end
  return num_turns
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  valid_move = valid_move?(board, index)
  if valid_move
    value = current_player(board)
    move(board, index, value)
  else
    turn(board)
  end
  display_board(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination # return the win_combination indexes that won.
    end
  end
  false
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw?(board)
  if full?(board) != true
    return false
  elsif won?(board) == false
    return true
  end
end

def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) != false
    return true
  end
end

def winner(board)
  positions_array = won?(board)
  if positions_array == false
    return nil
  elsif board[positions_array[0]].to_s == "X" || board[positions_array[0]].to_s == "O"
    return board[positions_array[0]].to_s
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board) != false
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end

end
