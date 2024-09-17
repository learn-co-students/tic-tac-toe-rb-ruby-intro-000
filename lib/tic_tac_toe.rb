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

def current_player(board)
  if turn_count(board).even?
  "X"
else
  "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
if valid_move?(board, index)
  character = current_player(board)
  move(board, index, character)
  display_board(board)
else
  turn(board)
end
end

def won?(board)
  WIN_COMBINATIONS.each do |combinations|
    if board[combinations[0]] == board[combinations[1]] && board[combinations[1]] == board[combinations[2]] && position_taken?(board, combinations[0])
  return combinations
  end
 end
 return false
end

def full?(board)
    board.all? do |space|
    space == "X" || space == "O"
    # if board[space[0]] == board[space[1]] && board[space[1]] == board[space[2]] && position_taken?(board, space[0])
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  win = won?(board)
  if win!=false
    return board[win[0]]
  end
end

def play(board)
turn(board) until over?(board)
if won?(board)
  puts "Congratulations #{winner(board)}!"
else
  puts "Cat's Game!"
end
end
