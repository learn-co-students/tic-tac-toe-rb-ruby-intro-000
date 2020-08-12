#CONSTANTS
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # First column
  [1,4,7],  # Second column
  [2,5,8],  # Third column
  [0,4,8],  # Top left to bottom right
  [2,4,6]  # Top right to bottom left
]


#HELPER METHODS
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index >= 0 && index <= 8
    if position_taken?(board, index) == false
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  token = current_player(board)
  puts "It's #{token}'s turn."
  puts "Please enter 1 - 9:"
  index = input_to_index(gets.chomp)
  if valid_move?(board, index) == true
    move(board, index, token)
    display_board(board)
  else
    puts "This is not a valid move."
    turn(board)
  end
end

def turn_count(board)
  moves_made = board.select do |i|
    i == "X" || i =="O"
  end
  return moves_made.length
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |i|
    board[i[0]] == board[i[1]] &&
    board[i[1]] == board[i[2]] &&
    position_taken?(board, i[0])
  end
end

def full?(board)
  if turn_count(board) >= 9
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board) && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if !won?(board) == false || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board).class == Array
    return board[won?(board)[0]]
  else
    return nil
  end
end


#PLAY METHOD
def play(board)
  until over?(board) == true
    turn(board)
  end

  if !won?(board) == false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
