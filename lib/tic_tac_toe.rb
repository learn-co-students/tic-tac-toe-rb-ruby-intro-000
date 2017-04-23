def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

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

def input_to_index(input)
  index = input.to_i - 1
end

def valid_move?(board,index)
  if (index.between?(0,8) == true && position_taken?(board,index) == false)
    true
  elsif (index.between?(0,8) == false || position_taken?(board,index) == true)
    false
  end  
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[1])
  end
end

def full?(board)
  board.none? do |empty|
    empty == " " || empty.nil?
  end
end

def draw?(board)
  won?(board) == nil && full?(board) == true
end

def over?(board)
  won?(board) == true || full?(board) == true
end

def turn(board)
  puts "Where would you like to go?"
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  validity = valid_move?(board,index)
  while validity != true
    puts "Invalid move.  Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    validity = valid_move?(board,index)
  end
  move(board,index,"X")
  display_board(board)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    "X"
  else
    "O"
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter +=1
    end
  end
  counter
end

def move (board,index,character)
  player = current_player(board)
  board[index] = player
  board
end

def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end