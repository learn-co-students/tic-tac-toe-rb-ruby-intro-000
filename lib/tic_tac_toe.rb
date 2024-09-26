WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    champ = winner(board)
    puts "Congratulations #{champ}!"
  else
    puts "Cat's Game!"
  end
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



def display_board(moves)
  puts " #{moves[0]} | #{moves[1]} | #{moves[2]} "
  puts "-----------"
  puts " #{moves[3]} | #{moves[4]} | #{moves[5]} "
  puts "-----------"
  puts " #{moves[6]} | #{moves[7]} | #{moves[8]} "
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
  board.each do |val|
    if val == 'X' || val == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  x = turn_count(board)
  if x % 2 == 0
    return 'X'
  else
    return 'O'
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination # return the win_combination indexes that won.
    else
      false
    end
  end
  if full?(board) == false
    return false
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def full?(board)
  board_full = true
  board.each do |item|
    index = board.index(item)
    if position_taken?(board, index) == false
      board_full = false
    end
  end
  return board_full
end


def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    win_combination = won?(board)
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      return "X"
    else board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      return "O"
    end
  else
    return nil
 end
end
