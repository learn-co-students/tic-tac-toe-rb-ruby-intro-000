WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else return false
  end
end

def valid_move?(board, index)
  if index < 0 || index > 8 || position_taken?(board, index) == true
    return false
  else return true
  end
end

def turn (board)
  puts "Current player is " + current_player(board) +"."
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == false
    turn (board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |slot|
    if slot == "X" || slot == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_combo_1 = win_combo[0]
    win_combo_2 = win_combo[1]
    win_combo_3 = win_combo[2]

    slot_index_1 = board[win_combo_1]
    slot_index_2 = board[win_combo_2]
    slot_index_3 = board[win_combo_3]

    if slot_index_1 == "X" && slot_index_2 == "X" && slot_index_3 == "X"
      return "X"
    elsif slot_index_1 == "O" && slot_index_2 == "O" && slot_index_3 == "O"
      return "O"
    end
  end
  return false
end

def full?(board)
  board.all? do |slot|
    slot == "O" || slot == "X"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    puts "Cat's games!"
    return true
  else return false
  end
end

def over?(board)
  if draw?(board) == true || won?(board) == "X" || won?(board) == "O"
    return true
  else return false
  end
end

def winner(board)
  if won?(board) == "X"
    return "X"
  elsif won?(board) == "O"
    return "O"
  else return nil
  end
end

def play(board)
  until over?(board) == true
    turn(board)
    if won?(board) != false
      break
    end
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
