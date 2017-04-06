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

def move(board, input_to_index, char)
  board[input_to_index] = char
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board,index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  char = current_player(board)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    puts "You have entered an invalid number. Please try again."
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |board_space|
      if board_space == "X"
        turn += 1
      elsif board_space == "O"
        turn += 1
      end
    end
    return turn
  end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|

      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3] && position_taken?(board, win_index_1)
  end
end

def full?(board)
  board.all? do |token| # token will equal "X", "O", " "
    #["X", "O", "X", "O", "X", "O", "X", "O", "X"]
    token == "X" || token == "O" # ruby conditions with && or || will evaluate each side as a full condition.
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
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) && board[won?(board)[0]] == "X"
    return "X"
  elsif won?(board) && board[won?(board)[0]] == "O"
    return "O"
  else
    return nil
end
end

def play(board)
  char = current_player(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
