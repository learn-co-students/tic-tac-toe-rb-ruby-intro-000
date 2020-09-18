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

def move(board, index, character)
board[index] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
!position_taken?(board, index) && index.between?(0,8)
end

def turn_count(board)
  turn_number = 0
board.each do |turn|
if turn == "X" || turn == "O"
turn_number += 1
end
end
turn_number
end

# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   index = input_to_index(input)
# if valid_move?(board, index)
#   move(board, index)
#   display_board(board)
# else
#   turn(board)
# end
# end

# if valid_move?(board, index)
#   move(board, index)
#  else
#   turn(board)
#  end
#  display_board(board)
# end
