# WIN_COMBINATIONS
WIN_COMBINATIONS = [
[0,1,2], #Top row
[3,4,5], #Middle row
[6,7,8], #Bottom row
[0,3,6], #First column
[1,4,7], #Second column
[2,5,8], #Third column
[0,4,8], #Left diagonal
[2,4,6], #Right diagonal
]

#display_board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index
def input_to_index(user_input)
  user_input.to_i - 1
end

#move
def move(board, index, token)
    board[index] = token
  end

#position_taken?
def position_taken?(board, index)
  if board[index] == " " ||
    board[index] == "" ||
    board[index] == nil
    return false
  elsif board[index] == "X" ||
    board[index] == "O"
    return true
  end
end

#valid_move?
def valid_move?(board, index)
  if index.between?(0, 8) == true && position_taken?(board, index) == true
    return false
  elsif index.between?(0, 8) == true
    return true
  end
end

#turn
def turn(board)
puts "Please enter 1-9:"
user_input = gets.strip
index = input_to_index(user_input)

if valid_move?(board,index) == true
  move(board, index, current_player(board))
  display_board(board)
else
  turn(board)
end
end

#turn_count
def turn_count(board)
  counter = 0
  board.each do |index|
    if index =="X" || index =="O"
      counter +=1
    end
  end
  counter
end

#current_player(board)
def current_player(board)
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
end

#won?
def won?(board)

  winning_combination = WIN_COMBINATIONS.select do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    if board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X"
      return win_combination
    elsif board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O"
      return win_combination
    end
  end

  empty_board = board.all? do |board_index|
    board_index == nil || board_index == " "
  end

  if empty_board
    return false
  elsif empty_board == false && winning_combination == []
    return false
  end
end

#full
def full?(board)
  full_board = board.all? do |board_index|
    board_index == "X" || board_index == "O"
  end
  incomplete_board = board.all? do |board_index|
    board_index == "X" || board_index == "O" || board_index = ""
  end
  if full_board
    return true
  elsif incomplete_board
    return false
  end
end

#draw method
def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
    end
end

#over method
def over?(board)
 if won?(board) && full?(board) == true
   return true
 elsif won?(board) && full?(board) == false
     return true
   elsif draw?(board) == true
     return true
   else
     return false
   end
 end

 #winner method
def winner(board)
  if won?(board) == false
    return nil
  else board[won?(board)[0]]
end
end

#play
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
