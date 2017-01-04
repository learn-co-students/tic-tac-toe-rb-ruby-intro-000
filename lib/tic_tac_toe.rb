def turn_count(board)
  turn_count = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      turn_count += 1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
  return current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

n = 1

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end
end


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

def won?(board)
  n = 0
  y = 1000
  WIN_COMBINATIONS.each do |winning_array|
    if board[winning_array[0]] == "X" && board[winning_array[1]] == "X" && board[winning_array[2]] == "X"
      y = n
    elsif board[winning_array[0]] == "O" && board[winning_array[1]] == "O" && board[winning_array[2]] == "O"
      y = n
    else
      n += 1
    end
  end
  if y != 1000
    return WIN_COMBINATIONS[y]
  elsif y == 1000
    return false
  end
end

def full?(board)
  if board.select{ |banana| banana == " "} != []
    return false
  else
    return true
  end
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  elsif board[won?(board)[1]] == "X"
    return "X"
  elsif board[won?(board)[1]] == "O"
    return "O"
  end
end
