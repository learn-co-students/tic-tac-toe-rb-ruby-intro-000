require "pry"

WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Top-Left-Bottom-Right Diagnoal
  [2,4,6] # Top-Right-Bottom-Left Diagnoal
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board, input_to_index, character)
def update_array_at_with(array, index, value)
  array[index] = value
end
update_array_at_with(board, input_to_index, character)
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  if won?(board) && draw?(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end
end

def turn_count(board)
  counter = 0
    board.each do |turn|
        if turn == "X" || turn == "O"
          counter += 1
        end
    end
  counter
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
      position_taken?(board, combo[0]) && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end
end

def full?(board)
  board.none? do |player|
    player != "X" && player != "O"
  end
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congrats " + board[won?(board)[0]]
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
