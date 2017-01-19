#prints out the array 'board' to look like a tic tac toe board
def display_board (board)

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

#Checks that the move is valid by making sure it is within the range of possible moves
def valid_move? (board, index)
  if (0..8) === index && board[index] === " "
    return true
  else
    return false
  end
end


#Sets the position of the board to "X" or "O"
def move (board, index, token)
  #token = current_player(board)
  board[index] = token
end

#Converts the user input of board position (from 1-9) to the correct position in the zero-indexed array (0-8)
def input_to_index(user_input)
  if user_input.to_i.class != Fixnum
    return -1
  end
  user_input = user_input.to_i
  user_input -=1
  return user_input
end


#Gets user input, and having verified its validity, makes the turn the user supplies
'''
def turn(board)
  puts "Please enter 1-9:"
  turn_number = gets.chomp
  index = input_to_index(turn_number)
  if valid_move?(board, index)
    move(board,index,token="X")
    display_board(board)
  else
    turn(board)
  end

end
'''


#checks how many turns have been played
def turn_count(board)
  turn_counter = 0
  board.each do |spot|
    if spot == "X" || spot.upcase == "O"
      turn_counter +=1
    end
  end
  return turn_counter
end

#tells us who the current player is, X or O

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def input_to_index(user_input)
  user_input.to_i - 1
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
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  9.times {turn(board)}
end

# Define your WIN_COMBINATIONS constant
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

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


#method to find out if the board contains any of the win combinations
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_combination = [combo[0], combo[1], combo[2]]
    windex1 = win_combination[0]
    windex2 = win_combination[1]
    windex3 = win_combination[2]

    pos1 = board[windex1]
    pos2 = board[windex2]
    pos3 = board[windex3]
    win_combo = [pos1,pos2,pos3]

    if pos1 == "X" && pos2 == "X" && pos3 == "X" || pos1 =="O" && pos2 == "O" && pos3 == "O"
      return win_combination
  end
end
  return false
end

def full?(board)
    if board.any? {|token| token == " "}
      return false
    else
      return true
    end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end


def winner(board)
  if won?(board)
    what_is_it = won?(board)
    return board[what_is_it[0]]
  else
    return nil
  end
end



def play(board)
  until over?(board)
    turn(board)

  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end
