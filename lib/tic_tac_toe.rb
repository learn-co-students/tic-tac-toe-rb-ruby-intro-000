WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right columnlib
  [0,4,8], # left diagonal
  [2,4,6]  # right diagonal
]

$winner_X_O =

def display_board(board)
  dashes = '-----------'
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts dashes
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts dashes
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, token)
  board[index] = "#{token}"
end

def position_taken?(board, index)
  if board[index] != " " && board[index] != "" && board[index] != nil
    true
  else
    false
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) || !index.between?(0, 8)
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  else
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  end
end

def turn_count(board)
  count = 0
  board.each {| elem | elem == "X" || elem == "O" ? count += 1 : count = count}
  return count
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 0 ? (return "X") : (return "O")
end

def won?(board)
  WIN_COMBINATIONS.each do | win_combination |
    if (position_taken?(board, win_combination[0]) && position_taken?(board, win_combination[1]) && position_taken?(board, win_combination[0])) &&
        ((board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") ||
          (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"))
            $winner_X_O = board[win_combination[0]]
            return true
    else
            false
    end
  end
  return false
end

def full?(board)
  full_array = board.select {| elem | elem == " " || elem == "" or elem == nil}
  if full_array.length > 0
      return false
  else
      return true
  end
end

def draw?(board)
  if won?(board) || !full?(board)
    return false
  else
    return true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
      return $winner_X_O
      else return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{$winner_X_O}!"
  elsif draw?(board)
    puts "Cats Game!"
  end  
end
