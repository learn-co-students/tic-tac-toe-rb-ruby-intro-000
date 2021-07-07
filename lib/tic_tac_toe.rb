board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [2,5,8],
  [1,4,7],
  [0,3,6],
  [0,4,8],
  [2,4,6]
  # ETC, an array for each win combination
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if [" ", "", nil].include?(board[index]) && index.between?(0, 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  chosen = input_to_index(gets.chomp)
  while !valid_move?(board, chosen)
    puts "Please enter 1-9:"
    chosen = input_to_index(gets.chomp)
  end

  move(board,chosen,current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if (turn_count(board) % 2) == 0
    return "X"
  else
    return "O"
  end

end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    end
  end
  false
end

def full?(board)
  board.all? do |space|
    space == 'X' || space == 'O'
  end
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
  if won?(board) != false
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
