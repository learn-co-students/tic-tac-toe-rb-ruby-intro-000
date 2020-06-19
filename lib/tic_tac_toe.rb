# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
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

def move(board, index, current_player = "X")
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  x=0
  while(x<=board.length-1)
    if(board[x]!=" ")
      count+=1
    end
    x+=1
  end
  return count
end

def current_player(board)
  if(turn_count(board)%2==0)
    return"X"
  else
    return"O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      win_index_1=win_combination[0]
      win_index_2=win_combination[1]
      win_index_3=win_combination[2]
      position_1=board[win_index_1]
      position_2=board[win_index_2]
      position_3=board[win_index_3]
      if((position_1=='X'&& position_2=='X'&& position_3=='X') || (position_1=='O'&& position_2=='O'&& position_3=='O'))
        return[ win_index_1,
              win_index_2,
              win_index_3]
      end
   end
    return false
end

def full?(board)
  full_board=0
  count=0
  while(full_board<=board.length-1)
    if(board[full_board]!=" ")
      count+=1
    end
    full_board+=1
  end
  if(count==full_board)
    return true
  else
    return false
  end
end

def draw?(board)
  if(full?(board)==true && won?(board)==false)
    return true
  else
    return false
  end
end


def over?(board)
    if(draw?(board)==true || (won?(board)!=false))
      return true
    elsif (full?(board)==false)
      return false
 end
end


def winner(board)
  index=[]
  if(won?(board)==false)
    return nil
  else
  index=won?(board)
  if(board[index[0]]=="X")
    return "X"
  elsif (board[index[0]]=="O")
    return "O"
  end
end
end


def play(board)
  until(over?(board)==true)
    turn(board)
  end
  if(winner?(board)==true)
    winner=winner?(board)
    puts"congratulations#{winner}"
  else
    puts"game is drawn"
end
