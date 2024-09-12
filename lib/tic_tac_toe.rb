
require 'pry'
################################################
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
################################################
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
################################################
def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
################################################
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
################################################
def input_to_index(user_input)
  index = user_input.to_i - 1
end
################################################
def valid_move?(board, index)
  if index.between?(0,9) && position_taken?(board, index) == false
    return true
  end
end
################################################
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
################################################
def move(board, index, value)
  board[index] = value
end
################################################
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
################################################
def turn_count(board)
  counter = 0
  board.each do |number|
    if number == "X" || number == "O"
      counter += 1
    end
  end
  return counter
end
################################################
def winner(board)
  if won?(board)
    combo = won?(board)
    winner = board[combo[0]]
      return winner
  else
    return nil
  end
end
################################################
def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] != " " && board[win_combination[0]]== board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]]
  end
end

def full?(board)
  board.all? do |index|
    index != " "
  end
end
################################################
def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end
################################################
def over?(board)
  if draw?(board) || won?(board)
    return true
  end
end
