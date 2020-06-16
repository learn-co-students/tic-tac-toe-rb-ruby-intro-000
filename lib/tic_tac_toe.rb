#code for display_board
def display_board(array)
  divider = "-" *11
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts divider
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts divider
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

# code your input_to_index and move method here!

def input_to_index(string)
  input = string.to_i
  user_input = input - 1
end

#code for move method
#method to represent the user input on the board in the terminal
def move(array,position,player_letter)
  #input logic here
  player_move = position
  array[player_move] = player_letter
end

# code your #position_taken? method here!
def position_taken?(array,index)
  if array[index] == " " ||array[index] == ""
    return false
  else
    return true
  end
end

# code your #valid_move? method here
def valid_move?(array,index)
   (index >=0 && index<9) && !position_taken?(array,index)
end

#code for turn method
def turn(array)
  puts "Please enter 1-9:"
  user_input = gets.strip
  user_move = input_to_index(user_input)
  if valid_move?(array,user_move)
    move(array,user_move,current_player(array))
    display_board(array)
  else 
    turn(array)
  end
end


#code for play method
def play(array)
  turns_so_far = 0
  while !over?(array)
    turn(array)
  end
  if won?(array)
    puts "Congratulations #{winner(array)}!"
  else
    puts "Cat's Game!"
  end
end

#code for turn_count method
def turn_count(arr)
  arr.count do |arr_item|
     arr_item != " "
  end
end

#code for current_player method
def current_player(arr)
  if turn_count(arr) % 2 != 0
    return "O"
  else
    return "X"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  
 #code for won? method 
def won?(board_array)
    #logic to check for a winning combination
    WIN_COMBINATIONS.detect do |combo|
      board_array[combo[0]] == board_array[combo[1]] && board_array[combo[2]] == board_array[combo[1]]&&position_taken?(board_array,combo[0])
        #winner_for_game = board_array[combo[0]]
        #return true
    end
  end

#code for full? method
def full?(board_array)
  board_check = board_array.all? do |space|
    space != " "
  end
  
  if board_check
    return true #situation for a draw
  else
    return false #situation for an in-progress game
  end
end

#code for draw? method
def draw?(board_array)
  full?(board_array) && !won?(board_array)
end

#code for over? method
def over?(board_array)
  draw?(board_array) || won?(board_array)
end

#code for winner method
def winner(board_array)
  winning_array = won?(board_array)
  if winning_array
    return board_array[winning_array[0]]
  end
end
