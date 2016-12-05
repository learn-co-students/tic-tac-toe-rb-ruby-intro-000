# Define your WIN_COMBINATIONS constant
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

# Helper Methods
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each{|place| place == 'O' || place == 'X'? counter += 1 : next }
  return counter
end

def current_player(board)
  return turn_count(board) % 2 == 0? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
      if position_taken?(board, win_combo[0]) && position_taken?(board, win_combo[1]) && position_taken?(board, win_combo[2]) && board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]]
        return win_combo
      end
  end
  return false
end

def full?(board)
  counter = 0
  (0..9).each do |index|
    if position_taken?(board, index)
      counter += 1
    end
  end
  if counter > 8
    return true
  else
    return false
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
  elsif full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    won?(board).each do |index|
      return board[index]
    end
  else
    return nil
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
