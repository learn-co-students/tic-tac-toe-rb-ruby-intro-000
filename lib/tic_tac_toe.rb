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

def move(array, index, value)
  array[index] = value
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X"
      counter += 1
    elsif position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) == 0 || turn_count(board).even?
    "X"
  else
    "O"
  end
end

def valid_move?(array, index)
  if index.between?(0, 8) && position_taken?(array, index) == false
    return true
  end
end

def position_taken?(array, index)
  if array[index] == " " || array[index] == "" || array[index] == nil
    return false
  else array [index]
    return true
  end
end

def turn(board)
  loop do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    value = current_player(board)
    if valid_move?(board, index)
      move(board, index, value)
      break
    end
  end
end

WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
  if false
    return false
  end
end

def full?(board)
  board.each do |index|
    if index == "X"
      true
    elsif index == "O"
      true
    else
      return false
    end
  end
  if true
    return true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == nil
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != nil || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != nil
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  loop do
    turn(board)
    if over?(board)
      break
    else
      display_board(board)
    end
  end
  if won?(board) != nil
    display_board(board)
    puts "Congratualations! Player #{winner(board)} has won!"
  else draw?(board) == true
    display_board(board)
    puts "This game has ended in a tie."
  end
end
