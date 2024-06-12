board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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

def move(board, index, player_token)
  board[index] = player_token
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

# Define your play method below
def play(board)
  counter = 0
  until counter == 9
    turn(board)
    counter += 1
  end
end

def play(board)
  until over?(board)
    turn(board)
end
if won?(board)
  winner(board) == "X" || winner(board) == "O"
  puts "Congratulations #{winner(board)}!"

else draw?(board)
      puts "Cat's Game!"
end
end

def turn_count(board)
counter = 0
  board.each do |board_number|
    if board_number == "X" || board_number == "O"
      counter += 1
end
end
counter
end


def current_player(board)
if turn_count(board) % 2 == 0
  return "X"
else
  return "O"

end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], # right column
  [0,4,8], #left diagonals
  [2,4,6] #right column
]

def won?(board)
  WIN_COMBINATIONS. each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_2)
      return win_combination
  end
end
      return false
    end

  def full?(board)
   board.all? {|space| space == "X" || space == "O"}
end


def draw?(board)
   if !full?(board) && !won?(board)
     return false
   elsif !won?(board) && full?(board)
       return true
   else won?(board)
     return false
   end
end


def over?(board)
  if full?(board) or won?(board) or draw?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end
