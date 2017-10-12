# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  (1..9).include?(user_input.to_i) ? user_input.to_i - 1 : -1
end

def move(board, pos, bleh)
  board[pos] = bleh
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  position_taken?(board,index) || !(0..8).include?(index) ? false : true
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  pos = input_to_index(input)
  validation = valid_move?(board,pos)
  if validation
    # puts "Please enter 1-9:"
    # input = gets.chomp
    # pos = input_to_index(input)
    # validation = valid_move?(board,pos)
    move(board,pos,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each{|elm| count += 1 if ["X","O"].include?(elm)}
  count
end

def current_player(board)
  (turn_count(board)+1) % 2 == 0 ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") || (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O")
  end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  # won?(board) ? "Congratulations #{winner(board)}!" : "Cat's Game!"
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
