require "pry"


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left columns
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal
  [2,4,6] #diagonal
]

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
   win_index_1 = win_combination[0]
   win_index_2 = win_combination[1]
   win_index_3 = win_combination[2]
   position_1 = board[win_index_1] # value of board at win_index_1
   position_2 = board[win_index_2] # value of board at win_index_2
   position_3 = board[win_index_3] # value of board at win_index_3
   if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
     return win_combination
   end
 end
 false
end

def full?(board)
  if board.any? {|i| i == nil || i == " "}
   return false
 else
   return true
 end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def draw?(board)
   if !won?(board) && full?(board)
     return true
   elsif!full?(board) && !won?(board)
     return false
   else won?(board)
     return false
   end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

def turn_count(board)
  counter = 0
  board.each do |spaces|
    if spaces == "X" || spaces == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

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

def move(board, index, player = "X")
  board[index] = player
end


def valid_move?(board, index)
  if position_taken?(board, index) || !(index).between?(0,8)
    return false
  else
    return true
  end
end # code your #valid_move? method here

  def position_taken?(board, index)
    if board[index] == "" || board[index] == " " || board[index] == nil
      return false
    else
      return true
    end
  end

  def update_array_at_with(array, index, current_player)
  array[index] = current_player(board)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
      current_player(board)
    else
      turn(board)
  end
end

def play(board)
  until over?(board)
      turn(board)
    end
    if won?(board)
      winner(board) == "X" || winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
    end
    if draw?(board)
      puts "Cat's Game!"
    end
end
