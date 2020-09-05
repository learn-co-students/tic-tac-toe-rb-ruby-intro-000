WIN_COMBINATIONS = [
  [0, 1 ,2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], #Middle column
  [2, 5, 8], #Right column
  [0, 4, 8], #Left diagonal
  [2, 4, 6]  #Right diagonal
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

def move(board, index, current_player)
board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
!position_taken?(board, index) && index.between?(0,8)
end

def turn_count(board)
turn = 0
board.each do |index|
  if index =="X" || index == "O"
    turn += 1
  end
end
return turn
end

def current_player(board)
  turn_count(board) % 2 == 0? "X":"O"
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination

    end
  end
    return false
  end

def full?(board)
  board.all? do |index| index == "X" || index == "O"
  end
end

def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if win_combination = won?(board)
  board[win_combination.first]
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
    puts "Cat's Game!"
end
end
