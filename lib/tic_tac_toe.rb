
#display_boarddef display_board(board)
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end



#move (add character input parameter)

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turn_count = 0
  board.each do |place|
    if place == "X" || place == "O"
        turn_count += 1
    end
  end
  return turn_count
end

def current_player(board)
  turn_even = (turn_count(board) % 2)
  player = turn_even == 0 ? "X" : "O"
  return player
end

#Turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def winning_set?(board, set, value) #array of position indices to test
  set.all? { |e| board[e] == value }
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

def won?(board)
  icons = ["X", "O"]
  icons.each do |icon|
    WIN_COMBINATIONS.each do |set|
      if
        winning_set?(board, set, icon)
        return set
      end
    end
  end
return false
end

def full?(board)
  if (board.include?(" ")) || board.include?(nil)
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
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  return  (won?(board) ? board[won?(board)[0]] : nil)
end

def play(board)
  while !over?(board)
    turn(board)
  end
  display_outcome(board)
end

def display_outcome(board)
  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  else draw?(board)
    puts "Cats Game!"
  end
end
