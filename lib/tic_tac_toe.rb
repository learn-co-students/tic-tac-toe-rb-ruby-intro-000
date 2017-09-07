WIN_COMBINATIONS = [
    [0,1,2],
    [2,5,8],
    [0,4,8],
    [6,4,2],
    [0,3,6],
    [3,4,5],
    [6,7,8],
    [1,4,7],
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
 puts "Please enter 1-9:"
 input = gets.strip
 index = input_to_index(input)
 if valid_move?(board, index)
     move(board, index, current_player(board))
 else
     turn(board)
   end
   display_board(board)
 end


def turn_count(board)
  counter = 0
  board.each do |count|
    if count == "X" || count == "O"
      counter += 1
    end
  end
  board = counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    cell_1 = board[win_index_1]
    cell_2 = board[win_index_2]
    cell_3 = board[win_index_3]

      if cell_1 == "X" && cell_2 == "X" && cell_3 == "X"
        return win_combination
      elsif cell_1 == "O" && cell_2 == "O" && cell_3 == "O"
        return win_combination
      else
        nil
       end
     end
   end

   def full?(board)
     if board.detect {|cells| cells == " " || cells == ""}
        false
     else
        true
     end
   end

   def draw?(board)
     if !won?(board) && full?(board)
         true
     else
         false
     end
   end

   def over?(board)
     if draw?(board) || won?(board)
       true
     elsif full?(board) == false
       false
     end
   end

   def winner(board)
    if won?(board) != nil
       won = won?(board)
         board[won[0]]
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
