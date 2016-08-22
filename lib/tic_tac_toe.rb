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
# position_taken? method
def position_taken?(board,location)        #if the position is occupied return true
  board[location] != " " && board[location] != ""
end
#valid_move method
def valid_move?(board,index)
  if position_taken?(board,index) || !(index.between?(0, 8))   # not valid move
    return false
  else
    return true
  end
end
def move(array,index,player)
  array[index]= player
  display_board(array)
end
def turn_count(board)   #  it 'counts occupied positions
  counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end
  end
 return counter
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  elsif (turn_count(board) % 2 != 0)
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index) == true
    move(board,index,current_player(board))
  else
    turn(board)
  end
end
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
def won?(board)
  WIN_COMBINATIONS.detect {|win_combination|
  (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
}
end
def full?(board)
  board.all? { |e|
    e == "X" || e == "O"
    }
end

def draw?(board)
  !won?(board) && full?(board)
end
def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
  end
def winner(board)
  if over?(board) && won?(board)  # there is a winner
    winarray = won?(board)
    if board[winarray[0]] == "X"
       return "X"
    else
      return "O"
    end
  elsif draw?(board) #no one is winner
    return false
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
      if winner(board) == "X"
        puts "Congratulations X!"
      elsif winner(board) == "O"
        puts "Congratulations O!"
      elsif draw?(board)
        puts "Cats Game!"
      end
end
