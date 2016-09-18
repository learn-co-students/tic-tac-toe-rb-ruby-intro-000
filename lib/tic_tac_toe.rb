WIN_COMBINATIONS = [ [0, 1, 2],
                     [3, 4, 5],
                     [6, 7, 8],
                     [0, 3, 6],
                     [1, 4, 7],
                     [2, 5, 8],
                     [2, 4, 6],
                     [0, 4, 8]
                   ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.chomp.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  (board[index].nil? || board[index] != " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each {|position| counter += 1 if position != " "}
  return counter
end

def current_player(board)
  counter = 0
  board.each{|position| counter += 1 if position != " "}

  x_or_o = counter % 2 == 0 ? "X" : "O"

  return x_or_o

end

def won?(board)

  WIN_COMBINATIONS.each do |sub_array|

    combination = []
    x_o_array = []

    sub_array.each do |sub_array_element|

    combination << sub_array_element
    x_o_array << board[sub_array_element]

    end

    return combination if x_o_array == ["X", "X", "X"] || x_o_array == ["O", "O", "O"]

  end

  return false

end

def full?(board)

  board.each{|element| return false if element == " "}

  return true

end

def draw?(board)

  return true if !won?(board) && full?(board)

  return false

end

def over?(board)

  return true if won?(board) || draw?(board)

  return false

end

def winner(board)

  return nil if won?(board) == false

  x_or_o = board[won?(board).first]

  return x_or_o

end

def play(board)
  counter = 0

  until counter == 9
    break if over?(board)
    turn(board)
    counter += 1
  end

  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end


=begin
  counter = 0
  until counter == 9
  turn(board)
  counter += 1
  break if over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}"
    elsif draw?(board)
      print "Cats Game"
  end
end
=end
