

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]


def display_board(board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

board=["  ","  ","   ","   ","  ","   ","  ","  ","  "]


def input_to_index(user_input)
  input = user_input.to_i
  index = input - 1
end


def move(board, index, player)
  board[index] = player
end


def position_taken?(board, index)
  !(board[index] == " " || board[index] =="" || board[index].nil?)
end


def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true
    else
      return false
    end
  end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = user_input.to_i - 1
  input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, "X")
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  c=0
  board.each do|bd|  if bd =="X"||bd =="O"
    c+=1
    end
  end
  c
end



def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
    else
      return "O"
      end
    end




def won?(board)
  WIN_COMBINATIONS.each do|win|
    win_index_1 = win[0]
    win_index_2 = win[1]
    win_index_3 = win[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return true
      elsif  position_1 == "O" && position_2 == "O" && position_3 == "O"
        return true
        end
      end
      return false
    end



def full?(board)
  board.all?{|token| token == "X" || token == "O"}
  end



def draw?(board)
  if !won?(board) && full?(board)
    return true
    else
      false
    end
  end



def over?(board)
  draw?(board)||board
  full?(board)
  end



def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
  win_index_0 = win_combination[0]
  win_index_1 = win_combination[1]
  win_index_2 = win_combination[2]
  if board[win_index_0] == "X" && board[win_index_1] == "X" && board[win_index_2] == "X"
    return "X"
    elsif board[win_index_0] == "O" && board[win_index_1] == "O" && board[win_index_2] == "O"
      return "O"
      elsif !won?(board)
        return nil
      else
      end
    end
  end




def play(board)
  c=0
  while c<9
    turn(board) 
    over?(board) == false
    c+=1
    if draw?(board) && over?(board)
      puts "Cats Game!"
      elsif over?(board) && won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif over?(board) == true
      end
    end
  end
