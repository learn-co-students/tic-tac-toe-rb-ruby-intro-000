WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1  
end

def move(board, index, token)
    board[index] = token
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  else
    false
  end  
end

def valid_move?(board, index)
    if index.between?(0,8) && !position_taken?(board, index)
      true
    end
end

def turn(board)
  puts "Please enter 1-9:"  
  user_input = gets.strip  
  index = input_to_index(user_input)
  if valid_move?(board, index)
     move(board, index, current_player(board)) #last variable i am confused about
     display_board(board)
  else  
    puts "Invalid Input"
        turn(board)
  end
end

def turn_count(board)
  # board.count{|token| token == "X" || token == "O"}

  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns

end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
end
end

def full?(board)
  if board.find {|i| i == " " || i == "" || i == nil}
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
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if answer = won?(board)
    return board[answer[0]]
  end
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
