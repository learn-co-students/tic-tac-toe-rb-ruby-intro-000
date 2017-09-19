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

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  (position_taken?(board,index) == false) && (0..8).include?(index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  if board.all? {|pos| pos == " " || pos == nil}
    return false
  end

  WIN_COMBINATIONS.each do |arr|
    if position_taken?(board, arr[0]) && board[arr[0]] == board[arr[1]] && board[arr[1]] == board[arr[2]]
      return arr
    end
  end
  false
end

def full?(board)
  board.all? {|pos| pos != " " && pos != nil}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  false
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end
  false
end

def winner(board)
  if won?(board)
    newarr = won?(board)
    return board[newarr[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
