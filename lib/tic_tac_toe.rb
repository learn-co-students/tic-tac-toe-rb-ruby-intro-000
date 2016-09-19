# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row wins
  [3,4,5], #middle row wins
  [6,7,8], #botom row wins
  [0,3,6], #left column wins
  [1,4,7], #middle column wins
  [2,5,8], #right column wins
  [0,4,8], #diagonal win
  [2,4,6] #diagonal win
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

def move(board, index, current_player) #####
  board[index] = current_player
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
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board) ####
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0

    board.each do |turns|
      if turns == "X" || turns == "O"
        counter += 1
      end
    end
  return counter
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_index|
#    win_index.each do |position|
      position_1 = board[win_index[0]]
      position_2 = board[win_index[1]]
      position_3 = board[win_index[2]]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_index # return the win_combination indexes that won.
      end
  end
 return false
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  a = full?(board)
  b = won?(board)
  if a == true && b == false
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) == true || won?(board) != false || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    win_index = won?(board)
    if board[win_index[0]] == "X"
      return "X"
    elsif board[win_index[0]] == "O"
        return "O"
    end
  end
  return nil
end

def play(board)
  while over?(board) != true
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end

# Define your play method below
#def play(board)
#  counter = 1
#  while counter <= 9
#    turn(board)
#    counter += 1
#  end
#end
