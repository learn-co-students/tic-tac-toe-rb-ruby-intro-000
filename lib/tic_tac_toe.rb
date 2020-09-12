WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  input = input.to_i
  input = input -1
  index = input
  return index
end


def move(board, index, player)
  board[index] = player
end


def valid_move?(board, index)
  if index.between?(0, 8)
    if (position_taken?(board, index) == true)
      return false
    else
      return true
    end
  else
    return false
  end
end


# Helper Method
#def position_taken?(board, index)
#  return !(board[index].nil? || board[index] == " ")
#end


def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == nil)
    return false
  elsif (board[index] == "")
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if (valid_move?(board, index) == true)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  for turn in board do
    if turn == "X"
      count += 1
    elsif turn == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
   x_turns = 0
   o_turns = 0
  for turns in board do
    if turns == "X" 
      x_turns += 1
    elsif turns == "O"
      o_turns += 1
    end
  end
  if o_turns > x_turns
    return "X"
  elsif o_turns < x_turns
    return "O"
  elsif (x_turns == o_turns)
    return "X"
  else
    return "kacy wtf"
  end
end 



def won?(board)
  for win_combination in WIN_COMBINATIONS do
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3  == "X"
      return win_combination
    end

    if position_1 == "O" && position_2 == "O" && position_3  == "O"
      return win_combination
    end
  end
  return false
end

def full?(board)
  for each in board do
    if each == " " || each == nil
      return false
    end
  end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if over?(board) == true
    if board[won?(board)[0]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O"
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) != false
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end