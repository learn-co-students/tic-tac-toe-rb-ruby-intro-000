
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

def input_to_index(move)
    index = move.to_i - 1
    index
end
  
def move(array, index, value)
    array[index] = value
end

def valid_move?(board, index)
    if position_taken?(board, index) || !index.between?(0, 8)
        return false
    else
        return true
    end   
end

def position_taken?(board, index)
    if board[index] == " "
        return false
    elsif board[index] == ""
        return false
    elsif board[index] == nil
        return false
    elsif board[index] == "X" || board[index] == "O"
        return true
    end
end

def turn_count(board)
    count = 0
    board.each do |element|
        if element == "X" || element == "O"
            count += 1
        end
    end
    return count
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
    move = gets.strip
    index = input_to_index(move)
    if valid_move?(board, index)  
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
        return win_combination
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
        return win_combination
      end   
    end
    return false
  end
  
  def full?(board)
    board.none? do |element|
      element == " "     
    end
  end
  
  def draw?(board)
    if full?(board) && !won?(board)
    return true
    end
  end
  
  def over?(board)
    if draw?(board) || full?(board) || won?(board)
      return true
    else 
      return false
    end
  end
  
  def winner(board)
    WIN_COMBINATIONS.each do |win_combination|
      if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
        return "X"
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
        return "O"
      end   
    end
    return nil
  end

#   def play(board)
#     count = 0
#     while count < 9 do
#     turn(board)
#     count += 1
#     end
#   end

  def play(board)
   while !over?(board)
    turn(board)
   end 
   if draw?(board)
    puts "Cat's Game!"
   end
   if won?(board)
    puts "Congratulations #{winner(board)}!"
   end
end
