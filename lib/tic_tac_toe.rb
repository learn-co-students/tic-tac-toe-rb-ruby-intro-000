board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  input = input.to_i - 1
end

def move (board, index, side)
  board[index] = side
  display_board(board)
end

top_row_win = [0,1,2]
middle_row_win = [3,4,5]
bottom_row_win = [6,7,8]
left_column_win = [0,3,6]
middle_column_win = [1,4,7]
right_column_win = [2,5,8]
left_diagonal_win = [0,4,8]
right_diagonal_win = [2,4,6]

WIN_COMBINATIONS = [top_row_win, middle_row_win, bottom_row_win, left_column_win, middle_column_win, right_column_win, left_diagonal_win, right_diagonal_win]

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
    side = current_player(board)
    move(board, index, side)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  counter = 0
  until counter == 9
    turn(board)
    counter += 1
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |winIndex|

    position_1 = board[winIndex[0]]
    position_2 = board[winIndex[1]]
    position_3 = board[winIndex[2]]

     if position_1 == "X" && position_2 == "X" && position_3 == "X"
       return winIndex
     elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
       return winIndex
     end
     end

     return false
   end

def full?(board)
  board.none?{|i| i == " "}
 end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def turn_count(board)
  turn_count = 0
  board.each do |numMoves|
    if numMoves == "X" || numMoves == "O"
      turn_count += 1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  puts "Welcome to Tic Tac Toe!"
  display_board(board)
  until over?(board)
  turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
      puts "Cat's Game!"
    end
end
