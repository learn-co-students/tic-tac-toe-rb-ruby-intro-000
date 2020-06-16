#These are my sample boards
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
board1=["X","X","X"," "," "," "," "," "," "]
board2=[" "," "," ","X","X","X"," "," "," "]
board3=[" "," "," "," "," "," ","X","X","X"]
board4 =["X"," "," ","X"," "," ","X"," "," "]
board5 =[" ","X"," "," ","X"," "," ","X"," "]
board6 =[" "," ","X"," "," ","X"," "," ","X"]
board7 =["X"," "," "," ","X"," "," "," ","X"]
board8 =[" "," ","X"," ","X"," ","X"," "," "]
board9= ["O","O","O"," "," "," "," "," "," "]
board10=["X","O","X","O","X","X","O","X","O"]
board11 =["X","O","X","O"," "," "," "," "," "]
win_arrays= [board1,board2,board3,board4,board5,board6,board7,board8]

#This is the display function
def display_board(board) # This is how we create a board
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#This will strings into numbers which is useful for inputs that come from the user
def input_to_index(user_input)
  user_input.to_i-1
end

#This is an assist function that will help with counting what turn is it
def turn_count(board)
  board.count{|token| token=="X"||token=="O"}
end

#This will determine which player is setting the letter on the board
#Curre_player function uses the turn_count method to determine which player is playing
def current_player(board)
  turn_count(board)%2==0? "X":"O"
end

#This uses the current player to put on a board that we have created. We still need to supply board and index
def move(board, index,current_player)
  board[index] = current_player
end

#This function will access if the position on the board is empty or not
def position_taken?(board,location)
  board[location] != " " && board[location] !=""
end

#This function will use the position_taken function is determine if the player is setting down on an "empty slot"
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board,index)
end

#All functions are use somewhat to complete this function. We also have it looped itself to get the inputs again.
def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
  while valid_move?(board,index)==false
    puts "This (#{index}) is not a valid move. Please input correct move"
    input=gets.strip
    index=input_to_index(input)
  end
  move(board,index,current_player(board))
  display_board(board)
  #puts 1+converted_number
end

#This turn function that I stole does not work that well
def turn2(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
  if valid_move?(board,index)
    move(board,index)
    display_board(board)
  else
    turn(board)
  end
end
#This line divides the two parts of this game. The above the dynamics of motion for this game
#The below is the play method which is at the bottom. The other methods evaluate whether or not the game has been won

#The winning combinations are all hard coded into the game since we have to determine all scenarios that the game has resulted in winning
top_row_win=[0,1,2]
mid_row_win=[3,4,5]
bot_row_win=[6,7,8]
left_col_win=[0,3,6]
mid_col_win=[1,4,7]
right_col_win=[2,5,8]
left_right_win=[0,4,8]
right_left_win=[2,4,6]
WIN_COMBINATIONS=[top_row_win,mid_row_win,bot_row_win,left_col_win,mid_col_win,right_col_win,left_right_win,right_left_win]

#I built this method to determine if the board has a winning combination regardless of if it is full or not
def define_win(win_combination,board)
  if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
    return win_combination # return the win_combination indexes that won.
  elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
    return win_combination # return the win_combination indexes that won.
  else
    false
  end
end

#the following will test the board against all winning combinations. will return array for winner and return false for no winners
def iswin(board)
  win=false
  WIN_COMBINATIONS.each do|slot|
    win=define_win(slot,board) if define_win(slot,board) !=false
  end
  win
end

#The method below will return an array for a board with a winning outcome and false for everything else
def won? (board)
  won=false
  if iswin(board)!=false
    won=iswin(board)
  else
    won=false
  end
  won
end

#This method checks if the board is full by checking if all the spots in the array is no longer empty
def full?(board)
  board.all?{|token| token=="X"||token=="O"}
end

#This method utilizes the full method, if board is complete and no one has won, then this is a draw scenario
#draws only happens on completed boards
def draw?(board)
  full?(board) && !won?(board)
end

#The game is over when someone has won or draw
def over?(board)
  draw?(board)==true || won?(board)!=false
end

def winner(board)
  if won?(board)
    board[won?(board)[2]]
  else
  end
end

board=board
#puts current_player(board)

def play(board)
  if won?(board)
    puts "Cat's Game!"
  elsif draw?(board)
    puts "This game is a draw"
  elsif !over?(board)
    turn(board)
    play(board)
  end
end


play(board)
