# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[
  #Horizontal
  [0,1,2],
  [3,4,5],
  [6,7,8],

  #Vertical
  [0,3,6],
  [1,4,7],
  [2,5,8],

  #Diagonal
  [0,4,8],
  [2,4,6],
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if meets_win_combination?(board,win_combination)
      return meets_win_combination?(board,win_combination)
    end
  end
  return false
end

def meets_win_combination?(board,win_combination)
  values_in_win_combination_same = board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]]
  values_in_win_taken = board[win_combination[0]] == "X" || board[win_combination[0]]== "O"
  if values_in_win_combination_same && values_in_win_taken
    return win_combination
  else
    false
  end
end

def full?(board)
  return board.all?{|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  #return WIN_COMBINATIONS.any?{|win_combination| possible_win_combination?(board,win_combination)}  ||  !won?(board)
  return full?(board) && !won?(board)
end

def possible_win_combination?(board,win_combination)
  values_in_win_combination_same = board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]]
  values_in_win_not_taken = board[win_combination[0]] == " " || board[win_combination[0]] == "   " || board[win_combination[0]] == nil
  return values_in_win_combination_same && values_in_win_not_taken
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  win_combination=won?(board)
  if !win_combination
    return nil
  else
    first_cell = win_combination[0]
    return board[first_cell]
  end
end


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
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      count+=1
    end
  end
  return count
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)

  until valid_move?(board,index)
    puts "#{input} : Invaild input"
    display_board(board)
    puts "Please enter 1-9:"
    input = gets
    index = input_to_index(input)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    winner=winner(board)
    puts "Congratulations #{winner}!"
  end
end
