
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # second row
  [6,7,8], #third row
  [0,3,6], #1st col
  [1,4,7], #2nd col
  [2,5,8], #3rd col
  [0,4,8], #1st diagnol
  [2,4,6], #2nd diagnol
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  input = input.to_i
  index = input - 1
  return index
end


def move(board, index, character)
  board[index] = character
end


def position_taken?(board,index)
  if board[index] == " " || board[index] == ""
    false
  elsif board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end


def valid_move?(board,index)
  if index.between?(0,8) && !position_taken?(board,index)
    return true
  end
end


def turn(board)
  puts "Please enter 1-9:"
  num = gets.to_i
  index = input_to_index(num)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
  else
    until valid_move?(board,index)
      puts "Please enter 1-9:"
      num = gets.to_i
      index = input_to_index(num)
    end
  end
end


def turn_count(board)
  count = []
  board.each do |cell|
    if cell == "X" || cell =="O"
      count.push(1)
    end
  end
  count.length.to_i
end


def current_player(board)
  num_ = turn_count(board)
  if num_% 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_0 = win_combo[0]
    win_index_1 = win_combo[1]
    win_index_2 = win_combo[2]

    position_1 = board[win_index_0]
    position_2 = board[win_index_1]
    position_3 = board[win_index_2]

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board,win_index_0)
      return win_combo
    end
  end
  return false
end


def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end


def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end


def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end


def winner(board)
  if win_combo = won?(board)
    board[win_combo.first]
  end
end


def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
