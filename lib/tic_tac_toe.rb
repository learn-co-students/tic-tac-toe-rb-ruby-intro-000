WIN_COMBINATIONS = [
  [0,1,2],  #top row win
  [3,4,5],  #middle row win
  [6,7,8],  #bottom row win
  [0,3,6],  #first columnn
  [1,4,7],  #second columnn
  [2,5,8],  #third columnn
  [0,4,8],  #diagonal win
  [2,4,6]  #other diagonal win
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index] == nil? || board[index] == " " || board[index] == "")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
#  if index.between?(0,8)
#    if !position_taken?(board, index)
#      true
#    else
#      false
#    end
#  end
end

def turn(board)
  puts "Please select a position 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |count|
    if count != " " && count != ""
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
    end
end

def full?(board)
  board.all? do |pos|
    pos == "X" || pos == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    win_array = won?(board)
    if board[win_array[0]] == "X"
      "X"
    else
      "O"
    end
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
