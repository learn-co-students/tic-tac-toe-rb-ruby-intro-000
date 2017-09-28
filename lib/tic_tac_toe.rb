WIN_COMBINATIONS = [
   [0,1,2], #top row
   [0,3,6], #left column
   [0,4,8], #top left diagonal
   [1,4,7], #mid column
   [2,4,6], #top right diagonal
   [2,5,8], #right column
   [3,4,5], #mid row
   [6,7,8]  #bottom row
 ]
 
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
 
 def move(board, index, c_player)
   board[index] = c_player
 end
 
 def position_taken?(board, index)
   if (board[index] == " " || board[index] == "" || board[index] == nil)
     false
   else
     true
   end
 end
 
 def valid_move?(board, index)
   if (index.between?(0,8) && !(position_taken?(board, index)))
     true
   else
     false
   end
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
   counter = 0
   board.each do |square|
     if square == "X" || square == "O"
       counter += 1
     end
   end
   return counter
 end
 
 def current_player(board)
   if turn_count(board) % 2 == 0
     "X"
   else
     "O"
   end
 end
 
 def won?(board)
   WIN_COMBINATIONS.each do |win_combination|
     if win_combination.all? { |i| position_taken?(board, i)}
       if board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]]
         return win_combination
       end
     end
   end
     return false
 end
 
 def full?(board)
   board.all?{ |i| i == "X" || i == "O" }
 end
 
 def draw?(board)
   if won?(board)
     false
   elsif full?(board)
     true
   else
     false
   end
 end
 
 def over?(board)
   if draw?(board) || won?(board)
     true
   else
     false
   end
 end
 
 def winner(board)
   if won?(board)
     return board[won?(board)[0]]
   end
 end
 
 # Define your play method below
 def play(board)
   until over?(board)
     turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   else
     puts "Cats Game!"
   end
 end