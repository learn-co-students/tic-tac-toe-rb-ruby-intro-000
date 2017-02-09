def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


WIN_COMBINATIONS = [
   [0, 1, 2], #top row
   [3, 4, 5], #middle row
   [6, 7, 8], #bottom row
   [0, 3, 6], #left column
   [1, 4, 7], #middle column
   [2, 5, 8], #right column
   [0, 4, 8], #top-left, middle-middle, bottom-right
   [2, 4, 6]  #top-right, middle-middle, bottom-left
]


def input_to_index(user_input)
   user_input = user_input.to_i - 1
end


def move(board, index, token)
   board[index] = token
end


def position_taken?(board, index)
   if board[index] == " " || board[index] == "" || board[index] == nil
      return false
   end

   if board[index] == "X" || board[index] == "O"
      return true
   end
end


def valid_move?(board, index)
   if index.between?(0, 8) && !position_taken?(board, index)
      true
   else
      false
   end
end


def turn(board)
   puts "Please enter 1-9:"

   user_input = gets.strip
   index = input_to_index(user_input)

   if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
   else
      turn(board)
   end
end


def turn_count(board)
   counter = 0

   board.each do |n|
      if n == "X" || n == "O"
         counter += 1
      end
   end

   counter
end


def current_player(board)
   if turn_count(board) % 2 == 0
      return "X"
   end

   if turn_count(board) % 2 == 1
      return "O"
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
      else
         false
      end
   end
   false
end


def full?(board)
   status = true

   board.each do |element|
      if element == " "
         status = false
      end
   end

   return status
end


def draw?(board)
   !(won?(board)) && full?(board)
end


def over?(board)
   if won?(board) || draw?(board) || full?(board)
      true
   else
      false
   end
end


def winner(board)
   if won?(board)
      won_board = won?(board)
      x = won_board[0]
      board[x]
   end
end


def play(board)
   until over?(board)
      turn(board)
   end

   if won?(board)
      puts "Congratulations #{winner(board)}!"
   end

   if draw?(board)
      puts "Cats Game!"
   end
end
