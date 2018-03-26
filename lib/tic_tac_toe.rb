WIN_COMBINATIONS =
[
  [0,1,2], #win top row
  [3,4,5], #win middle row
  [6,7,8], #win bottom row
  [0,3,6], #win left column
  [1,4,7], #win middle columns
  [2,5,8], #win right column
  [0,4,8], #win diagonal left to right
  [2,4,6]  #win diagonal right to left
]

def display_board(board)

  puts " #{board [0]} " "|" " #{board [1]} " "|" " #{board [2]} "
  puts "-----------"
  puts " #{board [3]} " "|" " #{board [4]} " "|" " #{board [5]} "
  puts "-----------"
  puts " #{board [6]} " "|" " #{board [7]} " "|" " #{board [8]} "

end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " " or board[index] == "" or board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if (0..8).include?(index) && position_taken?(board, index) == false
    true
  else
    false or nil
  end
end

def turn(board)
  current_player(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp

  index = input_to_index(user_input)

  if valid_move?(board, index)

    move(board, index, current_player(board))
    display_board(board)

  else
    puts "Please enter 1-9:"
    user_input = gets.chomp
  end
end

def turn_count(board)
  board.count do |turn|
     turn == "X" or turn == "O"
  end
end

def current_player(board)
  if (turn_count(board) + 1).odd?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = win_index_1
    position_2 = win_index_2
    position_3 = win_index_3
      if (board[position_1] == board[position_2] and board[position_1]== board[position_3]) &&
        position_taken?(board, position_1) && position_taken?(board, position_2) && position_taken?(board, position_3)
        true
      else
        false
      end
    end
  end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  won?(board)
  
  if !(full?(board))
    false
  elsif full?(board) && !(won?(board))
    true
  else full?(board) && won?(board)
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  if !(won?(board))
    nil
  elsif board[won?(board)[0]] == "X"
    "X"
  else board[won?(board)[0]] == "O"
    "O"
  end
end

def play(board)
  turn = 0
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
