# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

# Define display_board that accepts a board and prints
# out the current state.
#board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


#input_to_index
def input_to_index(input)
  index = input.to_i - 1
end

#move
def move(board, index, char)
  board[index] = char
end

#position_taken?
def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    false
  else
    true
  end
end

#valid_move?
def valid_move?(board, index)
  if !position_taken?(board,index) && index.between?(0,8)
    true
  else
    false
  end
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip

  index = input_to_index(input)
  until valid_move?(board, index)
    puts "Sorry, that is not a valid move. Try again. Enter 1-9"
    input = gets.strip
    index = input_to_index(input)
  end

  move(board, index, current_player(board))
  display_board(board)

end

# define #won?(board)
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position_taken?(board, combo[0]) && position_taken?(board, combo[1]) && position_taken?(board, combo[2]) && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end
end

# define #full?(board) method
def full?(board)
  board.all? { |position| position != " " }
end

# define #draw?(board) method
def draw?(board)
  if full?(board) && !won?(board)
    true
#  elsif !full?(board) && !won?(board)
#    false
  else
    false
  end
end

# define #over?(board) method
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# define #winner(board method)
def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end


# rspec spec/01_tic_tac_toe_spec.rb

#turn_count
def turn_count(board)
  turns_taken = 0
  board.each do | space |
    if space == "X" || space == "O"
      turns_taken += 1
    end
  end
  turns_taken
end

#current_player
def current_player(board)
  if turn_count(board) % 2 == 0
    player = "X"
  else
    player = "O"
  end
  player = turn_count(board).even? ? "X" : "O"
end


#define play(board) method
def play(board)
   until over?(board)
     turn(board)
   end

   if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
     puts "Cat's Game!"
   else
     nil
   end
end

# rspec spec/02_play_spec.rb
