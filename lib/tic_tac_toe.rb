WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  sep = "-----------"
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  puts row1
  puts sep
  puts row2
  puts sep
  puts row3

end

def input_to_index(input)
  num = input.to_i
  return num-1
end

def move(board, input, character)
  #idx = input_to_index(input)
  board[input] = character
  return board
end

def position_taken? (board, input)
  if board[input] == '' || board[input] == ' ' || board[input] == nil
    return false
  elsif board[input] =='X' || board[input] == 'O'
    return true

  end
end

def valid_move?(board, input)
  if position_taken?(board, input) == false && input.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  idx = input_to_index(input)
  if valid_move?(board,idx) == true
   move(board,idx,current_player(board))
   display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |i|
    if i == "X" || i == "O"
        turn+=1
    end
  end
  return turn
end

def current_player(board)
  current_turn = turn_count(board)
  current_turn.odd? == true ? "O" : "X"
  #isnt this saying if the current turn is odd put "o" other wise output x?
end

def won?(board)
  WIN_COMBINATIONS.each do |winning_array|
    if board[winning_array[0]] == "X" && board[winning_array[1]] == "X" && board[winning_array[2]] == "X"
      return winning_array
    elsif board[winning_array[0]] == "O" && board[winning_array[1]] == "O" && board[winning_array[2]] == "O"
      return winning_array
    end
  end
  return false
end

def full?(board)
  board.all? do |check|
    check == "X" || check == "O"
  end
end
# this will evaluate to true or false
def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    winner = won?(board)
    return board[winner[0]]
  end
  return nil
end

def play(board)
  puts "Welcome to Tic Tac Toe!"
  display_board(board)
 until over?(board) == true do
   turn(board)
 end
 if won?(board) != false
   win = winner(board)
   puts "Congratulations #{win}!"
 elsif draw?(board) == true
   puts "Cat's Game!"
 end
end
