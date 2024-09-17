
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0, 1, 2], #top gorisontal
[3, 4, 5], #middle gorisontal
[6, 7, 8], #bottom gorisontal
[0, 3, 6], #left vertical
[1, 4, 7], #middle vertical
[2, 5, 8], #right vertical
[0, 4, 8], #right diagonal
[2, 4, 6] #left diagonal
]

=begin
-------------#display_board----------------
Define a method that prints the current board representation based on the board argument passed to the method.
An empty board would be:
board = [" "," "," "," "," "," "," "," "," "]
display_board(board)
=end
def display_board(the_board)
  puts " #{the_board[0]} | #{the_board[1]} | #{the_board[2]} "
  puts "-----------"
  puts " #{the_board[3]} | #{the_board[4]} | #{the_board[5]} "
  puts "-----------"
  puts " #{the_board[6]} | #{the_board[7]} | #{the_board[8]} "
end

=begin
---------------------#input_to_index--------------
Once the user inputs where they would like to go on the board, we then have to convert this to the board index
multiple times. Instead of doing that in a lot of places, we can remove this repetitive code and put it in this
helper method. This method takes the user_input (which is a string), converts it to an Integer, and subtracts 1.
Remember that,from the player's point of view, the board contains spaces 1-9.
But, an array's indexes start their count at 0.
=end
def input_to_index(user_input)
    user_input.to_i - 1
  end

=begin
------------------#move-----------------
Your #move method must take in three arguments: 1) the board array, 2) the index in the board array that
the player would like to fill out with an "X" or and "O", and 3) the player's character (either "X" or "O").
We previously had you write this method with a default argument of "X" for the third argument,
 but that is no longer needed.
=end
def move(board, index, current_player)
  board[index] = current_player
end

=begin
---------------#position_taken?---------------
The #position_taken? method will be responsible for evaluating the position selected by the user against
the Tic Tac Toe board and checking to see whether or not that index on the board array is occupied.
If the user would like to fill out position 1, our #position_taken? method will check to see if that board index
 is vacant or if it contains an "X" or an "O".
 If the position is free, the method should return false (i.e. "not taken"), otherwise it will return true.
=end
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

=begin
------------#valid_move?------------------
Build a method valid_move? that accepts a board and an index to
check and returns true if the move is valid and false or nil if not.
 A valid move means that the submitted position is:

Present on the game board.
Not already filled with a token.
=end
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

=begin
--------------------#turn------------------
Build a method #turn to encapsulate the logic of a single
complete turn composed of the following routine:

Asking the user for their move by position 1-9.
Receiving the user input.
Convert user input to an index
If the move is valid, make the move and display board.
Otherwise (that is, if the move is invalid) ask for a new position until a valid move is received.
=end
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  #binding.pry
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

=begin
----------------#turn_count
This method takes in an argument of the board array and returns the number of turns that have been played.
=end
def turn_count(board)
  counter = 0
  board.each do |choice|
    if choice == "X" || choice == "O"
      counter += 1
    end
   end
   counter
end

=begin
---------------#current_player----------------
The #current_player method should take in an argument of the game board and use
the #turn_count method to determine
if it is "X"'s turn or "O"'s.
=end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    "X"
  elsif counter % 2 == 1
    "O"
  end
end

=begin
#won?
Your #won? method should accept a board as an argument and return false if there is no win combination present
in the board and return the winning combination indexes as an array if there is a win.
Use your WIN_COMBINATIONS constant in this method.
=end
def won?(board)
   WIN_COMBINATIONS.each do |combination|
     if combination.all? do |position|
        board[position] == "O"
      end
      return combination
    elsif
      combination.all? do |position|
        board[position] == "X"
      end
      return combination
    end
  end
    return false
end

=begin
#full?
The #full? method should accept a board and return true if every element in
the board contains either an "X" or an "O".
=end
def full?(board)
  board.none?{|i| i == " " }
end

=begin
#draw?
Build a method #draw? that accepts a board and returns true if the board has
not been won and is full and false if the board is
not won and the board is not full, and false if the board is won.
=end
def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

=begin
#over?
Build a method #over? that accepts a board and
returns true if the board has been won, is a draw, or is full.
=end
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

=begin
#winner
The #winner method should accept a board and return the token, "X" or "O" that has won the game given a winning board.
=end
def winner(board)
  win_index = won?(board)
  if over?(board)
    return board[win_index[1]]
  end
end

=begin
-------------#play---------------
The play method is the main method of the tic tac toe application and
 is responsible for the game loop. A tic tac toe game must allow players
 to take turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game. You can imagine the pseudocode:

until the game is over
  take turns
end

if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
=end
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    w = winner(board)
    puts "Congratulations #{w}!"
  elsif(draw?(board))
    puts "draw game"
    puts "Cat\'s Game!"
  end
end
