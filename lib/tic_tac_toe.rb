# Define your WIN_COMBINATIONS constant
#WIN_COMBINATIONS is a constant that holds a nested array for possible win index combinations
WIN_COMBINATIONS = [
  [0,1,2], #each of these will == win_combination when itereated with .each
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !(valid_move?(board,index))
    turn(board)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def turn_count(board)
board.count{|token| token=="X" ||token=="O"}
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 != 0
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
  #grab each index from the win_combination that composes a win
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  #load the value of the board at win_index_X
  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  #if the winning combiation indexes are of the same letter that that letter wins
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      #returns the winning combination array indexes aka win_combination aka the winning array
        return win_combination
    else
      false
    end
  end

  #if all the indexes are empty return false
  board.all? do |number|
    if number == " "
      return false
    end

  end
end

def full?(board)
  board.all?do |token|
  token == "X" || token == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_array = won?(board)
  if won?(board)!=false
    return board[win_array[0]]
  else
    return nil
  end
end

def play(board)

while !(over?(board))
  turn(board)
end
if won?(board)!=false
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cats Game!"
end
end
