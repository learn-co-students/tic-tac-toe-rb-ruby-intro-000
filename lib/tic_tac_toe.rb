WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

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

def move(board,index,character)
  board[index] = character
end

def position_taken?(board,index)
  if board[index] == "X" || board[index] == "O"
    true
  else
    false
  end
end

def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0, 8) == true
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board,index) == true
    character = current_player(board)
    move(board,index,character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count +=1
    else
    end
  end
    return count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        win_combination
      end
    end
end

def full?(board)
  board.all?{|value| value == "X" || value == "O"}
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if over?(board)
    token = won?(board)
    board[token[0]]
  end
end

def play(board)

  while over?(board) == false
    turn(board)
    over?(board)
  end

  if won?(board)
    token = won?(board)
    puts "Congratulations #{board[token[0]]}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end


end
