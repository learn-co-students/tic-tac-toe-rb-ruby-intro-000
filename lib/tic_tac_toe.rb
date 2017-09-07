WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
def display_board(board = [" "," "," "," "," "," "," "," "," "])
  row_separator = "-----------"
  element_separator = "|"

  board.each_with_index do |element, index|
    print " #{board[index]} "
    temp_index = index+1
    if (temp_index % 3 != 0)
      print element_separator
    else
      puts ""
      puts row_separator unless index == board.length-1
    end
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, player_type)
  board[position] = player_type
  board
end

def position_taken?(board, pos)
  !(board[pos] == " " || board[pos] == "" || board[pos] = nil)
end

def valid_move?(board, pos)
  if (pos >= 0 && pos < 9) && !position_taken?(board, pos)
    true
  else
    false
  end
end

def get_user_input
  puts "Please enter 1-9:"
  position = gets.strip
  index = input_to_index(position)
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    if (board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3]) && (board[win_index_1] == 'X' || board[win_index_1] == 'O')
      return win_combination
    end
  end
  return false
end

def full?(board)
  # empty_items = board.select{|element| empty_position?(element)}
  # if empty_items.length > 0
  #   false
  # else
  #   true
  # end
  board.all? {|element| element == "X" || element == "O"}
end

def empty_position?(position_value)
  if (position_value == "" || position_value == " ")
    true
  else
    false
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    win_combination = won?(board)
    board[win_combination[0]]
  end
end

def turn_count(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  turn_count(board) % 2 == 0? "X" : "O"
end

def turn(board)
  index = get_user_input
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
    index += 1
  else
    turn(board)
  end
  index
end

def play(board)
  success_index = 0
  while success_index < 9 && !over?(board)
    success_index = turn(board) + 1
  end

  if over?(board)
    if draw?(board)
      puts "Cats Game!"
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    end
  end
end
