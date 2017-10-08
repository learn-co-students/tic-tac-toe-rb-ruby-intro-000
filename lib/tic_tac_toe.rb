
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
 [0,1,2], # top row
 [3,4,5], # middle row
 [6,7,8], # bottom row
 [0,4,8], # left diagonal
 [2,4,6], # right diagonal
 [0,3,6], # vertical left
 [1,4,7], # vertical middle
 [2,5,8] # vertical right
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
 unless user_input =~ /\d/
   index = -1
   return index
 end
  input = user_input.to_i
  until input.between?(1,9) == true
    turn(board)
    input = user_input.to_i
  end
    index = input - 1
    return index
end

def move(board, index, player)
 board[index] = player
 return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
if position_taken?(board,index) == false && index.between?(0,8) == true
  return true
elsif index.between?(0,8) == false
  return false
end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  test_valid = valid_move?(board,index)
  if test_valid == false
   puts "Please enter 1-9:"
   user_input = gets.strip
   index = input_to_index(user_input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
 count = 0
 board.each do |space|
  if space != " " && space != ""
    count += 1
  else
    count += 0
  end
 end
   return count
end

def current_player(board)
 player = turn_count(board)
 even = player.even?
 even ?  "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_index|
    board_subarray = []
     win_index.each do |position|
       board_subarray << board[position]
     end
   if board_subarray.all?{|letters| letters == "X"} || board_subarray.all?{|letters| letters == "O"}
     return win_index
   end
  end
 #  if board.all?{|letters| letters == "" || letters == " "}
 #    return false
 # end
 return nil
end

def full?(board)
 if board.all?{|letters| letters == "X" || letters == "O"}
   return true
 else
   return false
 end
end

def draw?(board)
  status = won?(board)
if status == false || status == nil && full?(board) == true
  return true
elsif status == false && full?(board) != true
  return false
elsif status == true
  return false
end
end

def over?(board)
  if won?(board) || draw?(board)   #game is won OR it's a draw OR board is full
    return true
  else # game is not won and board is not full
    return false
  end
end

def winner(board)
 array_index = won?(board)
 if array_index == nil
   return nil
 end
 letters = []
 array_index.each{|index| letters << board[index] }
 if letters.all?{|letter| letter == "X"}
   return "X"
 elsif letters.all?{|letter| letter == "O"}
   return "O"
 else
   return nil
 end
end

def play(board)
#until the game is over, take turns, check for a winner or a draw and print out appropriate messages
  until over?(board) == true
    turn(board)
  end
  game_won = won?(board)
  game_draw = draw?(board)
  if game_won != nil
    puts "Congratulations #{winner(board)}!"
    return
  end
  if game_draw != false
    puts "Cat's Game!"
    return
  end
end
