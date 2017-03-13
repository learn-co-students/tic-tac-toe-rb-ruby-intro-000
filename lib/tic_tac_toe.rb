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
  cell1 = " #{board[0]} "
  cell2 = " #{board[1]} "
  cell3 = " #{board[2]} "
  cell4 = " #{board[3]} "
  cell5 = " #{board[4]} "
  cell6 = " #{board[5]} "
  cell7 = " #{board[6]} "
  cell8 = " #{board[7]} "
  cell9 = " #{board[8]} "
  box = "|"
  line = "-----------"
  print cell1, box, cell2, box, cell3
  print "\n",line
  print "\n",cell4, box, cell5, box, cell6
  print "\n",line
  print "\n",cell7, box, cell8, box, cell9, "\n"
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, "#{current_player(board)}")
    display_board(board)
  else turn(board)
end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter +=1
        end
      end
    return counter
end



def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    combo.each do
    if position_taken?(board, combo[0]) == true && position_taken?(board, combo[1]) == true && position_taken?(board, combo[2]) == true && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
      return combo
    end
  end
  end
  return false
end

def full?(board)
  if board.include?(" ")
    return false
  else return true
  end
  #board.none? {|i| i == " "}
end

def draw?(board)
  a = won?(board)
  b = full?(board)
  if a == false && b == true
    return true
  elsif a == false && b == false
    return false
  else return false
end
end

def over?(board)
  if full?(board) == true
    return true
  elsif won?(board) != false
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    return "#{board[won?(board)[0]]}"
  end
end

#def play(board)
#i = 0
#while i < 9
#  turn(board)
#  i += 1
#end
#end

#def play(board)
  #turn(board)
  #counter = 0
  #while counter < 8
    #turn(board)
    #if over?(board)
    #break
  #end
  #counter +=1
#end
#end

def play(board)
  until over?(board) == true
    turn(board)
    if draw?(board) == true
      break
    end
  end
  if draw?(board) == true
    puts "Cats Game!"
  elsif won?(board) != false
    puts "Congratulations #{winner(board)}!"
  end
end
