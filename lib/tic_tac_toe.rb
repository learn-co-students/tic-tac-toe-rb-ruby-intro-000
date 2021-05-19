

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def play(board)
  until over?(board)
    turn(board)

  if won?(board)
    if winner(board)=="X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"

    end


  elsif draw?(board)
    puts"Cat's Game!"


  end
end

end
#displays a tic tac toe board, with board spaces passed as an array
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#coverts a user's place on the board to the index integer
def input_to_index(user_input)
  index = user_input.to_i
  index -= 1
  return index
end


#checks the number to see if 1) the position is already taken and 2)it is an actual number
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
#turn_count
def turn_count(board)
  board.count{|token| token=="X"||token=="O"}
end

def current_player(board)
   i=0

  if board[i]=="X"
    i+=1
    board[i+1]="O"
  elsif board[i]=="O"
    i+=1
    board[i+1]="X"
  end
end



#Takes a users num and the board, and places the X or O char in that position
def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
#Asks user for a number, check if it is valid, and if it's not, recursively continues to ask for a number

#turn


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
#won?
def won?(board)

  WIN_COMBINATIONS.each{|win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

  if position_1 == "O" && position_2 == "O" && position_3 == "O"
    return  win_combination# return the win_combination indexes that won.
  elsif position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  end
  }
    return false
end


#full?
def full?(board)
  board.all?{|input| input=="O"||input=="X"}
end
#draw?
def draw?(board)

  if won?(board)==false && full?(board)==true
    true
  else
    false

  end

end
#over?
def over?(board)
   if won?(board) || full?(board) || draw?(board)
     true
  else
     false
   end
 end

 #winner
 def winner(board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end
