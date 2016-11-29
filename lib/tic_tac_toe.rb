# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], # Top row
[3,4,5], # Middle row
[6,7,8], # Bottom row
[0,3,6], # Top column
[1,4,7], # Middle column
[2,5,8], # End column
[0,4,8], # Left across
[2,4,6]  # Right Across
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input) #(user_input)
  input.to_i - 1          #user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
#(board[index] == " " || board[index] == "" || board[index] == nil) && index.between?(0, 8)?
!position_taken?(board, index) && index.between?(0, 8)?
true : false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    print "Invalid Entry: (position is taken)   "
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |symbol|
    if symbol == "X" || symbol == "O"
      counter += 1
    end
  end
  counter
#board.count{|symbol| symbol == "X" || symbol == "O"}
end

def current_player(board)
 if turn_count(board) % 2 == 0    #solution w/ if/else
   "X"
 else
   "O"
 end
# (turn_count(board) % 2 == 0) ?  # advanced solution w/ ternary operator
# X : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
 if !won?(board) && full?(board)
  puts "Cats Game!"
  true
  end
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  while !over?(board)
  turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def anothergame?(board)
  board = Array.new(9, " ")
  while true
    print "Would you like to play again? [y/n]: "
    case gets.strip
      when 'Y', 'y', 'j', 'J', 'yes' #j for Germans (Ja)
        play(board) # Game.play
      when /\A[nN]o?\Z/ #n or no
        break
    end
  end
end
