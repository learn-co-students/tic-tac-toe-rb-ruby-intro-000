# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [  
  [0,1,2], [3,4,5], [6,7,8], # horizontals
  [0,3,6], [1,4,7], [2,5,8], # verticals
  [0,4,8], [2,4,6]  # diagnals
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  converted_input = user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index >= 0 && index <= 8
    if position_taken?(board, index) == false
      true
    else
      false
    end
  else
    false
  end
end

def turn(board)
  index = gets.strip
  converted_index = input_to_index(index)
  
  if valid_move?(board, converted_index) == true
    move(board, converted_index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  
  board.each do |board_space|
    if board_space == "X" || board_space == "O"
      counter += 1
    end
  end
  
  counter
end

def current_player(board)
  player = " "
  
  if turn_count(board) % 2 == 0
    player = "X"
  else
    player = "O"
  end
  
  player
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    slot_1 = board[win_index_1]
    slot_2 = board[win_index_2]
    slot_3 = board[win_index_3]
    
    if slot_1 == slot_2 && slot_2 == slot_3 && position_taken?(board, win_index_1)
      return win_combination
    end
  end
  
  return false
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    puts "Please select a number 1-9: "
    
    turn(board)
  end
  
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end