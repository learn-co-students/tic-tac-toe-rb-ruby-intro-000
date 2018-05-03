WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
  
# MAIN UTILITY METHODS ##########################################
def display_board(b)
  puts [0,3,6].map {|i| " #{b[i]} | #{b[i+1]} | #{b[i+2]} \n"}.join("#{'-'*11}\n")
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    char = current_player(board) 
    move(board,index,char) 
    display_board(board)
  else 
    turn(board)
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
# END MAIN UTILITY METHODS #################################





# CHECK GAME STATUS ####################################
def full?(board)
  return board.none? {|xo| xo == " "}
end


def draw?(board)
  return full?(board) && !won?(board)
end


def over?(board)
  return draw?(board) || won?(board)
end


def won?(b) # b short for board
  WIN_COMBINATIONS.find do |win|
    b[win[0]] == b[win[1]] && b[win[1]] == b[win[2]] && b[win[0]] != " "
  end
end
# END CHECK GAME STATUS ####################################





# PLAYER METHODS ###########################################
def winner(board)
  return board[won?(board)[0]] if won?(board)
end

def turn_count(board) # empty spaces are set to " ", not "" anymore 
  return board.count {|piece| piece != " "}
end

def current_player(board) 
  return turn_count(board).even? ? "X" : "O"
end
# END PLAYER METHODS ########################################





# MOVE METHODS #############################################
def input_to_index(input)
  return input.to_i - 1
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  return !position_taken?(board, index) && index.between?(0,8)
end


def move(board, position, char)
  board[position] = char
end
# END MOVE METHODS #############################################
