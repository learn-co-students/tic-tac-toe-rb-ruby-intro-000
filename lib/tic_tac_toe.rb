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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
counter = 0
board.each do |position|
  if position == "X" || position == "O"
    counter += 1
  end
end
counter
end

def current_player(board)
  if turn_count(board).even? == true
  return  "X"
  else
    return "O"
  end
current_player(board)

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

def won?(board)

WIN_COMBINATIONS.find do |position|
  board[position[0]] == board[position[1]] && board[position[1]] == board[position[2]] &&  position_taken?(board, position[0])
end
end

def full?(board)
  board.all? do |spot|
spot == "X" || spot == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_position = won?(board)
    board[winning_position.first]
  end
end

def play(board)
  while over?(board) == !true
    turn(board)
  end
  if draw?(board) == true
    puts "Cat's Game!"
  end
  if winner(board) == "X"
    puts "Congratulations X!"

  end
  if winner(board) == "O"
    puts "Congratulations O!"
  end
end

#def play(board)
#  play = 0
#  while play < 9
#    turn(board)
#    play += 1
#  end
#end
