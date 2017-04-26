WIN_COMBINATIONS =[
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6]
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input=user_input.to_i
  user_input - 1
end

def move(board, index, character)
  board[index]= character
end


def position_taken?(board, index)
  if board[index] == "X"
    return true
  elsif board[index] == "O"
    return true
  elsif board[index] == " "||""||nil
    return false
  end
end

def valid_move?(board, index)
  if (index.between?(0,8) == true) && board[index]== " "
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input= gets.strip
  index = input_to_index(user_input)
    if valid_move?(board, index)== true
       move(board, index, character="X")
       display_board(board)
    else
      turn(board)
    end
end


def turn_count(board)
  counter= 0
  board.each do |count|
    if count == "X" || count == "O"
    counter +=1
    end
  end
counter
end

def current_player(board)
  count = turn_count(board)
  if count % 2== 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    if board[win_array[0]] == "X" && board[win_array[1]]== "X" && board[win_array[2]]=="X"||
       board[win_array[0]] == "O" && board[win_array[1]]== "O" && board[win_array[2]]== "O"
      return win_array
    end
  end
  false
end

def draw?(board)
  !won?(board) && full?(board)
  #  if won?(board)== false
  #   return true
  # else
  #   return false
  # end
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end


def over?(board)
    won?(board)||draw?(board)
end

def winner(board)
  if won?(board)
    win_array = won?(board)
    board[win_array[1]]
  elsif draw?(board)
    return nil
  end
end

def play(board)
  until  over?(board)
         turn(board)
  end

  if won?(board)!= false
    puts "Congratulations " "#{winner(board)}!"

  elsif draw?(board)
    puts "Cats Game!"
  end
end
