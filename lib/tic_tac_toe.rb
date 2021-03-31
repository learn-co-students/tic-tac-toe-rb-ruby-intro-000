WIN_COMBINATIONS = [
[0,1,2], # top_row
[3,4,5], # middle_row
[6,7,8], # bottom_row
[0,3,6], # left_column
[1,4,7], # center_column
[2,5,8], # right_column
[0,4,8], # left_diagonal
[6,4,2] # right_diagonal
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


def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
   if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
      return false
   else
      return true
   end
end

def valid_move?(array, index)
  index.between?(0,8) && !position_taken?(array, index)
end


def turn(array)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(array, index)
    move(array, index, current_player(array))
    display_board(array)
  else
    puts "Invalid input."
    turn(array)
  end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
    counter += 1
    else
    end
  end
  return counter
end


def current_player(array)
  turns_counted = turn_count(array)
    if
      turns_counted.even? == true
    return "X"
  else
    return "O"
  end
end


def won?(array)
  WIN_COMBINATIONS.find do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = array[win_index_1]
    position_2 = array[win_index_2]
    position_3 = array[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        nil
      end
  end
end


def full?(array)
  array.all? do |spaces|
    if spaces == "X" || spaces == "O"
      true
    else
      false
    end
  end
end


def draw?(array)
  won = won?(array)
  filled = full?(array)
  if won == nil && filled == true
    true
  elsif won.is_a?(Array) == true
    false
  elsif won == nil && filled == false
    false
  end
end


def over?(array)
  if draw?(array) == true || full?(array) == true || won?(array) != nil
    true
  else
    false
  end
end


def winner(array)
  victor = won?(array)
    if victor.is_a?(Array) == true
      return array[victor[0]]
    else
      nil
    end
end

def play(array)
  until over?(array) == true
    turn(array)
  end
  if won?(array).is_a?(Array) == true
    player = array[won?(array)[0]]
    puts "Congratulations #{player}!"
  elsif draw?(array) == true
    puts "Cat's Game!"
  end
end
