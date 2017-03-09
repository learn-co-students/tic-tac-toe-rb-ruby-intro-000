WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def display_board board
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index input
  input.to_i - 1
end

def move board, index, token
  board[index] = token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != "" && board[location] != nil
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count board
  turns = 0
  board.each do |index|
    if index != " " && index != "" && index != nil
      turns += 1
    end
  end
  return turns
end

def current_player board
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won? board
  WIN_COMBINATIONS.any? do |x|
    return x if x.all? { |i| board[i] == "X" }
    return x if x.all? { |i| board[i] == "O" }
  end
end

def full? board
  board.none? { |i| i.nil? || i == " " || i == ""}
end

def draw? board
  !won?(board) && full?(board)
end

def over? board
  won?(board) || draw?(board) || full?(board)
end

def winner board
  return nil if !won?(board)
  return "X" if won?(board).all? { |i| board[i] == "X" }
  return "O" if won?(board).all? { |i| board[i] == "O" }
end

def play board
  until over?(board)
    turn(board)
  end

  won?(board) ? (puts "Congratulations #{winner(board)}!") : (puts "Cats Game!")
end
