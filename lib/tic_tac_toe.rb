require 'pry'
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
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def valid_move?(board, index)
  if  !(position_taken?(board,index)) && index < 10 && index >=0
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  valid = valid_move?(board, index)
  if valid
    move(board,index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |element|
    if element == "O" || element == "X"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]

    positions = [position_1 = board[win_index_1],
    position_2 = board[win_index_2],
    position_3 = board[win_index_3]]

    if positions.all? {|i| i == "X"} || positions.all? {|i| i == "O"}
      return combination
    end
  end
  false
end

def full?(board)
  !(board.any?{|i| i == " "})
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    combination = won?(board)
    board[combination[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner(board) == "X" ? puts("Congratulations X!") : puts("Congratulations O!")
  else
    puts "Cats Game!"
  end
end
