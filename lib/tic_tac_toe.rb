def play(board)
  while turn_count(board) <= 8
  
    turn(board)
    puts "turn count is #{turn_count(board)}"

    won?(board)
    if over?(board) == true
      puts "winner is #{winner(board)}"
    
  end
  return puts "game has ended"
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1   
end

#def move(board, index, sign="X")
def move(board, index, sign)
  board[index] = sign
end


def position_taken?(board, index) 
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board,index)
end



def turn_count(board)
    count = 0
      board.each do |check|
        if check == "O" || check == "X"
          count +=1
        end
    end
    return count
  end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 == 1
    "O"
  else
    return
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  puts index
  if valid_move?(board, index) == true
    move(board, index, sign="X")
    display_board(board)
  else
   puts "your move is not valid, please try again"
   turn(board)
 end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    #puts win_combination.inspect
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3    

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
     return win_combination
    end
  end
  false
end


def full?(board)
#returns false for an in-progress game 
  i = 0
  while i <= 8
        if board[i] == "X" || board[i] == "O"
          true
        else
          return false
        end
        i = i + 1
  end
  #returns true for a draw (FAILED - 1)
  if true
    !won?(board)
  end
end

def draw?(board)
#DRAW accepts a board 
#returns true if the board has not been won but is full (TRUE if DRAW)
#false if the board is not won and the board is not full (FALSE if NO win && not yet finished)
#false if the board is won. (FALSE if WON)
      if full?(board) == true
        #puts "true A"
        true
      elsif won?(board) == false
        #puts "false B"
        false
      elsif
          WIN_COMBINATIONS.each do |win_combination|
          #puts win_combination.inspect
          win_index_1 = win_combination[0]
          win_index_2 = win_combination[1]
          win_index_3 = win_combination[2]
          
          position_1 = board[win_index_1] # load the value of the board at win_index_1
          position_2 = board[win_index_2] # load the value of the board at win_index_2
          position_3 = board[win_index_3] # load the value of the board at win_index_3    
    
            if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
             #puts "false C"
             false
            end
      end
    end
end


def wontf?(board)
  #accepts board, returns FALSE if NO WIN combination, RETURN WIN COMBO if WON
  WIN_COMBINATIONS.each do |win_combination|
    #puts win_combination.inspect
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3    

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
     return true
    end
  end
  false
end

def over?(board)
  #accepts board returns TRUE if WON, is a DRAW, or is FULL
  if wontf?(board) == true
    true
  elsif draw?(board) == true
    true
  elsif full?(board) == true
    true
  else
    false
  end
end



def winner(board)
#accepts BOARD, return "X" or "O" that has won the game. return FALSE if no winner
  WIN_COMBINATIONS.each do |win_combination|
    #puts win_combination.inspect
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3    

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      #puts "position_1: A"
      #puts position_1
      return position_1
    end

  end
    #puts "nil"
    nil
end
