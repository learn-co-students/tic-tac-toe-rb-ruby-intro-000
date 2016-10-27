#WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #second row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #diagonal left to right
  [2, 4, 6]  #diagonal right to left
]

#display board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input to index
def input_to_index(user_input)
  useri = user_input.to_i
  useri - 1
end

#move
def move(array , index , character)
  array[index] = character
  return array
end

#position taken?
def position_taken? (board, index)
  if board[index] == "X"
    true
  elsif board[index] == "O"
    true
  elsif board[index] == ""
    false
  elsif board[index] == " "
    false
  elsif board[index] == nil
    false
  else
    false
  end
end

#valid move?
def valid_move? (board, index)
    if index < 0 || index > 8 #i have not learned helper methods.
      return false
    elsif board[index] == "O" || board[index] == "X"
      return false
    else
    return true
  end
end

#turn
def turn(board) #why does this needs the argument board? i guess they get the other variables inside the method.
  puts "Please enter 1-9:"
  input = gets
  input_i = input_to_index(input)
  if valid_move?(board, input_i) == true && position_taken?(board, input_i) == false && current_player(board) == "X"
    move(board , input_i , "X")
    display_board(board)
  elsif valid_move?(board, input_i) == true && position_taken?(board, input_i) == false && current_player(board) == "O"
    move(board , input_i , "O")
    display_board(board)
  else
  turn(board)
  end
end

#def turn(board) #why does this needs the argument board? i guess they get the other variables inside the method.
#  puts "Please enter 1-9:"
#  input = gets
#  input_i = input_to_index(input)
#  if valid_move?(board, input_i) == true && position_taken?(board, input_i) == false
#    puts "Good Job Friend"
#  else
#    turn(board)
#  end
#end


#turn count
def turn_count(board)
  counter = 0
    board.each do |box|
      if box == "X"
      counter += 1
      elsif box == "O"
      counter += 1
      else
      counter += 0
     end
  end
  return counter
end


# won??
def won? (board) #it has to iterate over every nested array, to check if it matches. if it matches, return the array.
    winner_in = ""
    counter = 0
    WIN_COMBINATIONS.each { |win_combination|
      index_1 = win_combination[0]
      index_2 = win_combination[1]
      index_3 = win_combination[2]
      win_1 = board[index_1]
      win_2 = board[index_2]
      win_3 = board[index_3]
       if win_1 == "X" && win_2 == "X" && win_3 == "X"
         winner_in = "X"
         return win_combination
       elsif win_1 == "O" && win_2 == "O" && win_3 == "O"
         winner_in = "O"
         return win_combination
       else
         counter += 1
       end
       if counter == 8 #if it failed for every factor, it means it's either a draw or the game is still in progress.
         return false
       end
       }
 end

 #full?
def full?(board)
    if board.none? { |b| b == " " || b == " " || b == nil}
      return true
    else
      return false
     end
end

def draw?(board)
won_r = won?(board)
full_r =full?(board)
if won_r == false && full_r == true
  return true
else
  return false
end
end

#current player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#winner
def winner (board)
  if won?(board) != false
   win_array = won?(board)
   return board[win_array[1]]
  else
   return nil
  end
end

def over?(board)
   if full?(board) == true #check if board is full
    # if won?(board) != false || draw?(board) == true #this is supposed to signify ove
   return "true"
     #else
     #return false
    # end
   elsif won?(board) != false #now this time, the board isn't full. so we check if somebody won. ask if won != false
   return true #because somebody actually won. return true.
   else
   return false
  end
end

# THE HELPER METHODS ARE ALL GOOD PLEASE DO NOT TAMPER FURTHER#####
#play method here
def play(board)

  gameover = over?(board)
  gamewon = won?(board)
  gamedraw = draw?(board)
  if gamedraw != false
    puts "Cats Game!"
  end
  if gamewon != false
    winner_r = winner(board)
    puts "Congratulations #{winner_r}!"
  end
  while gameover == false && gamewon == false && gamedraw == false
    puts "This is one turn!"
    turn(board)
    gameover = over?(board)
    gamewon = won?(board)
    gamedraw = draw?(board)
     if gamewon != false
       winner_r = winner(board)
       puts "Congratulations #{winner_r}!"
       break
     end
     if gamedraw == true
       puts "Cats Game!"
       break
     end
    # if gameover == true
    #   winner_r = winner(board)
    #   if winner_r == "X"
    #     puts "Congratulations #{winner_r}!"
    #     break
    #   elsif winner_r == "O"
    #     puts "Congratulations #{winner_r}!"
    #     break
    #   end
    # end
  end
end
