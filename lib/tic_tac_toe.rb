require 'pry'

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

 WIN_COMBINATIONS =
    [[0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input.to_i - 1
end

def move(board,input,char)
  board[input]= char
end


def position_taken?(board, index)
      !(board[index].nil? || board[index] == " ")
end


def valid_move?(board,index)
      if position_taken?(board,index) || !index.between?(0,8)
        return false
      else
        return true
      end
end

def turn(board)
  puts "Please enter 1-9:"
   input=gets.strip
   index=input_to_index(input)
   if valid_move?(board,index)

        move(board,index,current_player(board))
        display_board(board)
    else
        turn(board)
  end
end

def turn_count(board)
  counter=0
  board.each do |element|
    if element != " " && element != ""
     counter+=1
   end
   end
   return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end


def won?(board)

   WIN_COMBINATIONS.each do |win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    end
  end
   false
 #  if position_taken?(board,win_combination[0]) && board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]]
 #   return win_combination
 #  end
 # end
 # false
end

full_board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
incomplete_board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]

def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if combo = won?(board)
    return board[combo[0]]
  end
end

# def play(board)
#   display_board(board)
#   turn(board) until over?(board)
# if won?(board)
#     puts "Congratulations #{winner(board)}!"
#   elsif draw?(board)
#     puts "Cat's Game!"
#   end
# end

def play(board)
  display_board(board)
  until over?(board)
  turn(board)
  end
  if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end
