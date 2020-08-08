WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
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

def move(board, position, value)
  board[position] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn_count(board)
  counter = 0
  board.each do |board_space|
    board_space != " " ? counter += 1 : nil
end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    turn = current_player(board)
    move(board, index, turn)
  else
    puts "Please try again"
    turn(board)
  end
    display_board(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
     return win_combo
   elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combo
    end
  end
  if (board == [" ", " ", " ", " ", " ", " ", " ", " ", " "] || board == ["","","","","","","","",""])
    return false
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
 if (!won?(board) && full?(board))
   return true
 end
end

def over?(board)
  if (won?(board) || full?(board) || draw?(board))
    return true
  end
end

def winner(board)
  win_combo = won?(board)
  if won?(board)
    token = win_combo[0]
    if board[token] == 'X'
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board)
      turn(board)
      current_player(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end

end
