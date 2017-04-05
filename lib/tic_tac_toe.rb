WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], # VERTICAL WINS
  [0, 3, 6], [1, 4, 7], [2, 5, 8], # HORIZONTAL WINS
  [0, 4, 8], [2, 4, 6]                 # DIAGONAL WINS
]



def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

 def turn(board)
   puts "Please choose a number between 1 and 9"
   input = gets.strip
   user_move = input_to_index(input)

   if valid_move?(board, user_move)
     player = current_player(board)
     move(board, user_move, player)
     display_board(board)
   else
     turn(board)
   end
 end

 def turn_count(board)
   turn = 0
   board.each do |xo|
     if xo == "X" || xo == "O"
       turn += 1
     end
   end
 turn
 end

 def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
 end

 def won?(board)
     WIN_COMBINATIONS.each do |win|
       win_index_1 = win[0]
       win_index_2 = win[1]
       win_index_3 = win[2]

       position_1 = board[win_index_1]
       position_2 = board[win_index_2]
       position_3 = board[win_index_3]

       if position_1 == "X" && position_2 == "X" && position_3 == "X"
         return win
       elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
         return win
       else
         false
       end
     end
     false
   end

 def full?(board)
   board.all? do |index|
      index == "X" || index == "O"
    end
 end

 def draw?(board)
   !won?(board) && full?(board)
 end

 def over?(board)
   won?(board) || full?(board) || draw?(board)
 end

 def winner(board)
    if won?(board)
      board[won?(board)[0]]
    end
  end

def play(board)
  until over?(board)
    turn(board)
  end

  if  won?(board)
      puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
