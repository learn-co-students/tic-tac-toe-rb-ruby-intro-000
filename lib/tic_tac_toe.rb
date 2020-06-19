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
  turns = 0
  board.each do |spot|
    if spot != " "
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Top to bottom diagonal
  [6,4,2]  # Bottom to top diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    spot_1 = board[combo[0]]
    spot_2 = board[combo[1]]
    spot_3 = board[combo[2]]

    if (spot_1 == "X" && spot_2 == "X" && spot_3 == "X") || (spot_1 == "O" && spot_2 == "O" && spot_3 == "O")
      return combo
    end
  end
  false
end

def full?(board)
  index = 0
  until index == 9
    if !position_taken?(board, index)
      return false
    end
    index += 1
  end
  true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  false
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
  false
end

def winner(board)
  if won?(board)
    combo = won?(board)
    return board[combo[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
