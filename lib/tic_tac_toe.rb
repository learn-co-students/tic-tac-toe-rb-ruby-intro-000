
WIN_COMBINATIONS = [
                  [0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8], #^across
                  [0, 3, 6],
                  [1, 4, 7],
                  [2, 5, 8], #^down
                  [0, 4, 8],
                  [2, 4, 6] #^diagonal
                   ]


def input_to_index(input)
  index = (input.to_i - 1)
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, marker)
  board[index] = marker
end

def position_taken?(board, index)
 if board[index] == "" || board[index] == " " || board[index] == nil
   false
 else
   true
 end
end

def valid_move?(board, index)
  if index.to_i.between?(0, board.length) && !position_taken?(board, index)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  num = gets.chomp
  numb = input_to_index(num)
  if valid_move?(board, numb) == true
      move(board, numb, current_player(board))
      display_board(board)
  else
    puts "Invalid number, try again:"
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each { |xo| counter += 1 if xo == "X" || xo == "O" }
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    arr1 = combo[0]
    arr2 = combo[1]
    arr3 = combo[2]
        if ((board[arr1] == "X") && (board[arr2] == "X") && (board[arr3] == "X")) || ((board[arr1] == "O") && (board[arr2] == "O") && (board[arr3] == "O"))
         combo
        end
   end
end

def full?(board)
  board.all? { |x_o| x_o == "X" || x_o == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board) != nil
     won_array = won?(board)
     return board[won_array[0]]
  end
end

def play(board)
  until over?(board)
     turn(board)
  end

  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
