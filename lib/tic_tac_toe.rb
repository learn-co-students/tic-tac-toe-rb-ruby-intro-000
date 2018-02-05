# require "pry"

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal
  [2,4,6]  # Diagonal
]

def display_board(board)
  puts " #{board[0]} ""|"" #{board[1]} ""|"" #{board[2]} "
  puts "-----------"
  puts " #{board[3]} ""|"" #{board[4]} ""|"" #{board[5]} "
  puts "-----------"
  puts " #{board[6]} ""|"" #{board[7]} ""|"" #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

#move(board, 0, "O")

def move(board, index, default_player)
  board[index] = default_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true
  else return false
  end
end

def turn(board)
#    default_player = "X"

    default_player = current_player(board)

    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index) == true
      move(board, index, default_player) && display_board(board)
    elsif over?(board) == false
      turn(board)
    else over?(board) == true
      false
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        false
      end
    end
   false
end

def full?(board)
   board.all? { |e| e != " "}
end

def draw?(board)
  won?(board) == false && full?(board) == true
end

def over?(board)
  won?(board) != false || full?(board) == true || draw?(board) == true
end

def winner(board)
  if won?(board)
    index = won?(board)[0]
    board[index]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if over?(board) && draw?(board) == false
      puts "Congratulations #{winner(board)}!"
  else over?(board) && draw?(board) == true
      puts "Cat's Game!"
  end
end
