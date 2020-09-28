def greeting(input)
return input
end

def input_to_index(input)
  index = input.to_i
  index -= 1
  return index
end

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS =
 [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def valid_range?(index)
  good_range = index >= 0 && index < 9
return good_range
end

def valid_move?(board, index)
!position_taken?(board, index) && valid_range?(index)
end

def move(board, index, character)
  board[index] = character
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player(board)
  while !valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0 #create a variable called counter
  board.each do |count| #create a variable called count that goes through each index of the board array
    if count == "X" || count == "O" #check if the index is occupied by X or O
    counter +=1 #if the space has X or O, add 1 to counter.
    end
  end
  return counter
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |match|
    board[match[0]] == board[match[1]] &&
    board[match[1]] == board[match[2]] &&
    position_taken?(board, match[0])
  end
end

def full?(board)
  board.all? do |taken|
    taken == "X" || taken == "O"
  end
end

def draw?(board)
!(won?(board)) && full?(board)
end


def over?(board)
  if draw?(board)
    return true
  elsif won?(board) && !(full?(board))
    return true
  elsif won?(board) && full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if combo_array = won?(board)
    #no iterations here
    index = combo_array[0]
    return board[index]
  end
end

def congratulate(board)
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else puts "Cat's Game!"
  end
end
