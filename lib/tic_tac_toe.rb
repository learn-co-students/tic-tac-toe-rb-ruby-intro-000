WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # left diagonal
  [2,4,6] # right diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i-1
end

def move(board,index,token)
  board[index] = token
end

def position_taken?(board,index)
  board[index] != " "
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "Please make your move 1 ~ 9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 == 1
    "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.detect do |winner_board|
    if (board[winner_board[0]] == "X" && board[winner_board[1]] == "X" && board[winner_board[2]] == "X") || (board[winner_board[0]] == "O" && board[winner_board[1]] == "O" && board[winner_board[2]] == "O")
      return winner_board
    else
      false
    end
  end
end

def full?(board)
  board.none? {|token| token == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.detect do |winner_board|
  if (board[winner_board[0]] == "X" && board[winner_board[1]] == "X" && board[winner_board[2]] == "X")
      return "X"
    elsif (board[winner_board[0]] == "O" && board[winner_board[1]] == "O" && board[winner_board[2]] == "O")
      return "O"
    else
      false
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
