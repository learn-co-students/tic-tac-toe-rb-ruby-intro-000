# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

# Display Board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Converts input to index_1
def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  board[index] = character
  board
end

def position_taken?(board, index)
  if index == nil || board[index] == nil
    false
  elsif board[index] == " " || board[index] == ""
    false
  else
    true
  end
end

def valid_move?(board, index)
  empty_board = board.all? { |i| i == " " }

  if board == empty_board && index > 8
    false
  elsif board == empty_board && index < 0
    false
  elsif board == empty_board
    true
  elsif position_taken?(board, index)
    false
  elsif index >= 0 && index <= 8
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip

  until valid_move?(board, input_to_index(input))
    puts "Please enter 1-9:"
    input = gets.strip
  end

  move(board, input_to_index(input), current_player(board))
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |item|
    if item != "" && item != " "
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return 'X'
  end
  'O'
end

def won?(board)
  empty = board.all? do |item|
    item == " "
  end

  if empty
    return false
  end

  WIN_COMBINATIONS.each do |combination|
    index_1 = combination[0]
    index_2 = combination[1]
    index_3 = combination[2]

    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination
    else
      false
    end
  end
  false
end

def full?(board)
  empty = board.all? { |i| i == " " }
  any = board.any? { |i| i == " " }

  if empty
    return false
  elsif any
    return false
  else
    true
  end
end

def draw?(board)
  if !full?(board)
    return false
  elsif won?(board).class == Array
    return false
  end

  true
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if draw?(board) || won?(board).class != Array
    return nil
  else
    winner_board = won?(board)
    return board[winner_board[0]]
  end
end

def play(board)
  until over?(board) do
     turn(board)
   end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
