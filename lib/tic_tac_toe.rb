require "pry"
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]]

def input_to_index(input)
  index=input.to_i
  index=index-1
  if index >=0 || index <=8
    return index
  else
    return -1
  end
end

def move(board,index,char)
  board[index]=char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index <=8 && index >=0
    if !position_taken?(board,index)
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  puts "Enter a position: "
  input=gets
  index=input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    while !valid_move?(board,index)
      puts "Enter a position: "
      input=gets
      index=input_to_index(input)
    end
  end
end

def turn_count(board)
  turn_count=0
  board.each do |position|
    if position=="X" || position=="O"
      turn_count+=1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end
end

def won?(board)
  if board.include?("X") || board.include?("O")
    count=0
    WIN_COMBINATIONS.each do |win_combo|
      #binding.pry #sets each variable in WIN_COMBINATIONS to a single variable
      win_1=win_combo[0]
      win_2=win_combo[1]
      win_3=win_combo[2]
      if board[win_1] == "X" && board[win_2] == "X" && board[win_3] == "X"
        return win_combo
      elsif board[win_1]=="O" && board[win_2]=="O" && board[win_3]=="O"
        #binding.pry
        return win_combo
      else
        count+=1
      end
    end
    if count==board.length()
      return false
    end
  else
    count=0
    (0..board.length()).each do |i|
      if position_taken?(board,i)
        count+=1
      end
    end
    if count==board.length()
      return false
    end
  end
end

def full?(board)
  if !won?(board)
    count=0
    board.each do |position|
      if position=="X" || position=="O"
        count+=1
      end
    end
    if count==board.length()
      return true
    else
      return false
    end
  else
    return false
  end
end

def draw?(board)
  if full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    if !full?(board)
      return false
    end
  end
end

def winner(board)
  if won?(board)
    returned_win=won?(board)
    won?(board).each do |position|
      if board[position]=="X"
        return "X"
      else
        return "O"
      end
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)=="X"
    puts "Congratulations X!"
  elsif winner(board)=="O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
