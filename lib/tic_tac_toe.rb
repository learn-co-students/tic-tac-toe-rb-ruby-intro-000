# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1= win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    if board[win_index_3] == board[win_index_2] && board[win_index_2] == board[win_index_1] && (board[win_index_1] == "X" || board[win_index_1]=="O")
      return win_combination
    end
  end
  return false
end


def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  result= won?(board)
  if result
    return board[result[0]]
  end
end

# Helper Methods
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
  level=0
  board.each do |spot|
    if spot == "X" || spot =="O"
      level += 1
    end
  end
  return level
end

def current_player(board)
  player = ""
  level = turn_count(board)
  if level % 2 == 0
    player = "X"
  else
    player= "O"
  end
  return player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  while !(over?(board)) do
    turn(board)

  end
  if won?(board)
    champ= winner(board)
    puts "Congratulations #{champ}!"
    #response= "Congratulations #{champ}!"
  #  return response
  elsif draw?(board)
    puts "Cat's Game!"
    #response = "Cat's Game!"
  #  return response
  end
end
