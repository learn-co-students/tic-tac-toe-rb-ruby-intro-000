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

def display_board(board = [" "," "," "," "," "," "," "," "," "])
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board,position)
  if position.between?(0,8)
    if position_taken?(board,position) == true
      return false
    else
      return true
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
  else
    puts "Your entry is not valid, try again"
    input =gets.strip
  end
  display_board(board)
end


def play(board)
    while !over?(board)
      turn(board)
    end

    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board) == true
      puts "Cats Game!"
    end
end

def turn_count(board)
  turn = 0
  board.each do |move|
    if move != " " && move != ""
      turn += 1
    end
  end
  return turn
end

def current_player(board)
 if turn_count(board) % 2 == 0
   "X"
 else
   "O"
 end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

          if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
            return win_combination
          end
    end
    return false
end

def full?(board)
 !(board.any? {|position| position == " "})
end

def draw?(board)
  if won?(board)
    false
  else
    full?(board)
  end
end

def over?(board)
  if won?(board) != false || full?(board) == true || draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  end
end
