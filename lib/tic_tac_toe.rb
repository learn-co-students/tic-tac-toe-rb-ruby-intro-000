require"pry"

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # bottom row
  [0,3,6], #first column
  [1,4,7], #second column
  [2,5,8], #third column
  [0,4,8], #diagonal1
  [2,4,6] #diagonal2
]

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(user_input)
  user_input.to_i -  1

end

def move (board, index, value)
  board[index] = value
end

def position_taken?(board, location)
  board[location] == "X" || board[location] == "O"
  # board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  # value = "X"
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |str|
    if str == "X" || str == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combos|   #changed from detect to each
    win_index_1 = combos[0]
    win_index_2 = combos[1]
    win_index_3 = combos[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combos
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combos
    else
      false
    end
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
  #   true
  # # elsif !full?(board) && !won?(board)
  # #   false
  # else
  #   false
  # end
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    # binding.pry
     combo = won?(board)
     board[combo[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

# it 'asks for players input on a turn of the game' do
#   board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#   allow($stdout).to receive(:puts)
#   allow(self).to receive(:over?).and_return(false, true)
#
#   expect(self).to receive(:gets).at_least(:once).and_return("1")
#
#   play(board)
# end
