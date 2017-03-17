# Helper Method

#Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

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

def move(board, index, player_token)
  board[index] = player_token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  # For Rake need to add STDIN. before gets!
  # input = STDIN.gets.strip
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_count=0
    board.each do |entry|
      if (entry == "X" || entry =="O")
        turn_count+=1
      end
    end
  return turn_count
end

def current_player(board)
  (turn_count(board).even?) ? current_player="X" : current_player="O"
  # return current_player #unecessary since implicitly return!
end

def won?(board)
    WIN_COMBINATIONS.each do |win|
        board_win = []
        win_index_1 = win[0]
        position_1 = board[win_index_1]
        win_index_2 = win[1]
        position_2 = board[win_index_2]
        win_index_3 = win[2]
        position_3 = board[win_index_3]

         if ( position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O" )
           board_win.push(win_index_1, win_index_2, win_index_3)
           return board_win
         end
    end
  false
end

# def full?(board)
#   board.all? do |pos|
#   	pos == "X" || pos == "O"
#   end
# end

# More concise as above
def full?(board)
  board.all? {|pos| pos == "X" || pos == "O"}
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
  # won?(board) == true || full?(board) == true || draw?(board) == true
  won?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win|
      win_index_1 = win[0]
      position_1 = board[win_index_1]
      win_index_2 = win[1]
      position_2 = board[win_index_2]
      win_index_3 = win[2]
      position_3 = board[win_index_3]

      if ( position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O" )
        return position_1
      end
  end
  nil
end

def play(board)
    until over?(board) do
      turn(board)
    end

    if won?(board)
      winner(board) == "X" ? winner_token="X" : winner_token="O"
      puts "Congratulations #{winner_token}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
end


# board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
# play(board)
