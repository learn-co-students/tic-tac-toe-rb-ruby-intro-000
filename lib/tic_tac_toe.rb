require "pry"
WIN_COMBINATIONS = [[0, 1, 2], #top row win
[3, 4, 5], #mid row win
[6, 7, 8], #bottom row win
[1, 4, 7], #mid column win
[2, 5, 8], #right column win
[0, 3, 6], #left column win
[0, 4, 8], #left top to bottom right diagonal win
[2, 4, 6]] #right top to bottom left diagonal win

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  (user_input).to_i - 1 
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, position)
  if board[position] == " "
    false
    elsif board[position] == "X" || board[position] == "O"
    true 
  else 
    nil 
  end
end 

def valid_move?(board, position)
  if !position_taken?(board, position) && ((board[position]) == "" || (board[position]) == " ") && 8 >= position && position >= 0
    true
  else 
    false
end
end

def turn(board)
  puts "Please select a number from 1-9."
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
  counter = 0
  board.each do |player_symbol|
    if  player_symbol == "X" || player_symbol == "O"
    counter += 1 
    end
  end
  return counter
end

def current_player(board)
if turn_count(board) .even?
  then "X" 
else 
  "O"
end
end

def won?(board)
   WIN_COMBINATIONS.detect do |win_conditions|
      if position_taken?(board,win_conditions[0]) && board[win_conditions[0]] == board[win_conditions[1]] && board[win_conditions[1]] == board[win_conditions[2]] 
           return win_conditions
      end
   end
   return false
end

def full?(board)
 board.none? {|spot| spot == " "} 
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else 
    return false
  end
end 

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board) && position_taken?(board,win_conditions[0]) && board[win_conditions[0]] == board[win_conditions[1]] && board[win_conditions[1]] == board[win_conditions[2]]
    return win_conditions[0]
  end
end

def winner(board)
  winning_board = won?(board)
  if winning_board != false
    position = winning_board[0]
  if board[position] == "X"
    return "X"
  else
    return "O"
end
end
end

def play(board)
  while !over?(board)
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
else
  puts "Cat's Game!"
end
  end


# def play(board)
#   if !over?(board)
#     turn(board)
#   else
#     winner(board)
#   end
# end