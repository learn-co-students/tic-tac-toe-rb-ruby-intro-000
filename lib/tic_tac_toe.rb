require 'pry'

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
  if !valid_move?(board, index)
    puts "Input is invalid. Try another number."
    turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board)
    puts "Congratulations, #{winner}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "O" || token == "X"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.any? do |combo|
    position_1 = board[combo[0]]
    position_2 = board[combo[1]]
    position_3 = board[combo[2]]
    win_1 = position_taken?(board, combo[0])
    win_2 = position_taken?(board, combo[1])
    win_3 = position_taken?(board, combo[2])

    if win_1 == true && win_2 == true && win_3 == true &&
      position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combo

    elsif win_1 == true && win_2 == true && win_3 == true &&
      position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    end
  end
end

def full?(board)
  board.all? do |full|
    full.include?("X") || full.include?("O")
  end
end

def draw?(board)
  full?(board) == true && won?(board) == false
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if combo = won?(board)
    if combo.all? {|i| board[i] == "X"}
      "X"
    elsif combo.all? {|i| board[i] == "O"}
      "O"
    end
  else
    return nil
  end
end
