
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

def move(board, index, token)
  board[index] = token
  display_board(board)
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if index.between?(0, 8) && valid_move?(board, index)
    move(board, index, token)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |token|
    if token == "X" || token == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]
    if position_taken?(board, win_combination[0])
      if position_1 == position_2 && position_2 == position_3
        return win_combination # return the win_combination indexes that won.
      end
    end
  end
  false
end

def full?(board)
  if !board.find{|element| element == " "}
    true
  else
    false
  end
end

def draw?(board)
  if full?(board)
    if !won?(board)
      return true
    end
  end
  false
end

def over?(board)
  if won?(board).class == Array || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if !won?(board)
    nil
  else
    pos = won?(board)[0]
    board[pos]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
