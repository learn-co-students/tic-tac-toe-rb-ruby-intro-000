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

def turn_count(board)
 turns = 0 
  board.each do |character|
    if character == "X" || character == "O"
      turns +=1 
    end
  end
  return turns
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  elsif turn_count(board).odd?
    return "O"
  end
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

# Define your play method below







# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5], 
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

 
def won?(board)
  WIN_COMBINATIONS.each { |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    
      if (position_1== "X" && position_2 == "X" && position_3 == "X")
        return win_combination
      elsif (position_1== "O" && position_2 == "O" && position_3) == "O"
        return win_combination
      end 
      }
      return false
end

def full?(board)
  if board.include? (" ")
    return false 
  else
    return true
  end
end   

def draw?(board)
  if !won?(board) && full?(board)
    return true 
  elsif won?(board) && full?(board)== false
    return false
  elsif won?(board) == true
  end 
end 

def over?(board)
  if won?(board) || draw?(board)|| full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  index= [ ]
  index = won?(board)
  if !won?(board)
    return nil
    elsif board[index[0]] == "X"
      return "X"
    elsif board[index[0]] == "O"
      return "O"
    
  end
end

def play(board)
  until over?(board)== true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
    
    
    