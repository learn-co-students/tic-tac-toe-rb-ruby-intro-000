
def position_taken?(board, index)
if  (board[index].nil? || board[index] == " ")
return false
  else true
end
end


WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    if (board[wincombo[0]]) == "X" && (board[wincombo[1]]) == "X" && (board[wincombo[2]]) == "X"
      return wincombo
    elsif (board[wincombo[0]]) == "O" && (board[wincombo[1]]) == "O" && (board[wincombo[2]]) == "O"
      return wincombo
    end
  end
if (board == 'X' || board == 'O')
  return false
end
end


def full?(board)
  if board.include?  " "
    return false
  else true
  end
end

=begin
def draw?(board)
if !won?(board) && full?(board)
  return true
elsif !won?(board) && !full?(board)
  return false
elsif won?(board)
  return false
end
=end

def draw?(board)

if (!won?(board) && full?(board))
  return true
elsif !(won?(board) && full?(board))
  return false
elsif won?(board)
    return false
  else true
end
end


def over?(board)
  if (won?(board)) || (draw?(board)) || (full?(board))
    return true
else
  false
end
end


def winner(board)

if i = won?(board)
return board[i.first]

end
end

def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end


 def input_to_index(user_input)
    user_input = user_input.to_i - 1

  end


   def valid_move?(board, index)
    if (board[index] == 'X' || board[index] == 'O')
     false
     elsif  index.between?(0, 8) == true
       true
    else
      nil
    end
end


def move(board, index, play)
 board[index] = play
 end


def turn(board)
 puts "Please enter 1-9:"
 user_input = gets.strip
 index = input_to_index(user_input)
 if valid_move?(board, index)
   move(board, index, play)
   display_board(board)
else
   puts "Please enter 1-9:"
   user_input = gets.strip

 end
 end


 def turn_count(board)
    counter = 0
    board.each do |i|
      if (i == "X" || i == "O")
        counter += 1
      end
    end
  return counter
  end




  def current_player(board)
     count = turn_count(board)
       if (count % 2 == 0)
         player = "X"
       else
         player = "O"
       end
       return player
     end




def play(board = ["X", " ", " ", " ", " ", " ", " ", " ", " "])
  input = gets
  if over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations " + winner(board) + "!"
   else
      draw?(board)
     puts "Cat's Game!"

    end
  end
