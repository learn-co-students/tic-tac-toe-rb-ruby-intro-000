def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Top left to bottom right
  [2,4,6]] # Top right to bottom left

def over?(board) #overthough this one ...
won?(board) || draw?(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |winner|
    if board[winner[0]] == board[winner[1]] && board[winner[1]] == board[winner[2]] && board[winner[0]] != " "
      return winner
    end
  end
  return false
end

def full?(board)
!board.any? { |space|  space == " " }
end

def draw?(board)
  !won?(board) && full?(board)
end

x_win_diagonal = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]

def winner (board)
if index = won?(board)
    board [index.first]
end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  turns = 0
  board.each do |counter|
    if counter == "X" || counter == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turn_count(board)%2 == 0 ? (return "X") : (return "O")
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board,index,current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

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

def  play(board)
until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
