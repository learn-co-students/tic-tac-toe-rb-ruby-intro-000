# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def won?(board)
end_value = false
  WIN_COMBINATIONS.each do |combo|
    if combo.all?{|position| board[position] == "X"} || combo.all?{|position| board[position] == "O"}
    end_value = combo

  end
end
return end_value
end

def full?(board)
  return !(board.include?(" "))
end

def draw?(board)
return !won?(board) && full?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if won?(board) == false
    return nil
  else return board[won?(board)[0]]
  end
end

# code your #valid_move? method here
def valid_move?(board, index)
if index.between?(0,9) && position_taken?(board, index) == false
  return true
end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
if board[index] == " " || board[index] == "" || board[index] == nil
  return false
elsif board[index] == "X" || "O"
  return true
end
end

def turn_count(board)
counter = 0
  board.each do |value|
    if value != " " && value != "" && value != nil
      counter += 1
    end
  end
    return counter
  end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, choice, token)

  board[choice] = token

end

def input_to_index(input)
  input.to_i - 1
end

def turn(board)
token = current_player(board)
puts "Please enter a number 1-9:"
choice = input_to_index(gets)
if valid_move?(board, choice)
  move(board, choice, token)
else
  puts "Sorry, invalid"
  turn(board)
end
end

def play(board)
until over?(board)
  turn(board)
  display_board(board)
end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else puts "Cats Game!"
  end
end
