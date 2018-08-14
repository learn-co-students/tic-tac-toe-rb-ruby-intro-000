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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif index.between?(0,8)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "invalid"
        turn(board)
end
end

def turn_count(board)
turns = 0
board.each do |space| # space is a local variable to hold each position in the board array
if space == "X" || space == "O"
  turns += 1
end
end
return turns
end

def current_player(board)
  count = turn_count(board)
if count % 2 == 0
  return "X"
else
  return "O"
end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      elsif !board.all?
        false
      else
        false
	   end
  end
end

def full?(board)
  board.all? {|token| token == "X" || token == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
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
win_combination = won?(board)
if win_combination
  win_location = win_combination[0]
  board[win_location]
end
end

def play(board)
    until over?(board)
      current_player(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end
end
