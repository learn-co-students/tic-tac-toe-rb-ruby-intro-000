WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # first column
  [1,4,7], # second column
  [2,5,8], # third column
  [0,4,8], # top left to bottom right diagonal
  [2,4,6]  # top right to bottom left diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && (board[index] == " " || board[index] == "" || board[index] == nil)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  while valid_move?(board, index) == false
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end

  char = current_player(board)
  move(board, index, char)
  display_board(board)
end

def turn_count(board)
  occupied_spaces = board.select{ |space| space == "X" || space == "O"}
  return occupied_spaces.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  counter = 0
  while counter < WIN_COMBINATIONS.length
  win_index = WIN_COMBINATIONS[counter]
  position_1 = board[win_index[0]]
  position_2 = board[win_index[1]]
  position_3 = board[win_index[2]]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return WIN_COMBINATIONS[counter]
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return WIN_COMBINATIONS[counter]
    else
      counter += 1
    end
  end
end

def full?(board)
  board.all? do |position|
    !(position.nil? || position == " ")
  end
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) == true || draw?(board) == true || won?(board) != nil
    return true
  else
    return false
  end
end

def winner(board)
  winning_array = won?(board)
  if winning_array == nil
    return nil
  elsif board[winning_array[0]] == "O"
    return "O"
  else
    return "X"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cats Game!"
    end
end
