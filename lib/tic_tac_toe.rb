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

def move(board, index, player_token)
  board[index] = player_token
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
  player_token = current_player(board)
  if valid_move?(board,index)
    move(board,index,player_token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |player_char|
    if player_char == "X" || player_char  == "O"
      counter += 1
    end
  end
  return counter
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
  WIN_COMBINATIONS.all? do |full_board|
  #grab each index from the curret full_board array
  f_index_1 = full_board[0]
  f_index_2 = full_board[1]
  f_index_3 = full_board[2]

  #if each index is occupied, return true
    if position_taken?(board,f_index_1) == true && position_taken?(board,f_index_2) == true && position_taken?(board,f_index_3) == true
      #returns true if board is full
        return true
    end
  end
end

def draw?(board)
  if full?(board)==true && won?(board)==false
    return true
  end
end

def over?(board)
  if won?(board)==true || draw?(board) ==true || full?(board)==true
    return true
  end
end

def winner(board)
  if won?(board)
    win_array = won?(board)
    board[win_array[0]]
  else
    nil
  end
end

def play(board)
  counter = 0
  until counter == 9
      counter += 1
      turn(board)
  end
end
