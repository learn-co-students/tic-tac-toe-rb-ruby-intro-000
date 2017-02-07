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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player_token)
  board[index] = player_token
end

def position_taken?(board, location)
  !(board[location] == " ") && !(board[location] == "")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def collect_input
  puts "Please enter 1-9:"
  input = gets.strip
  return input_to_index(input)
end

def input_to_index(input)
  return input.to_i - 1
end

def turn(board)
  index = collect_input
  until index.between?(0,8) && valid_move?(board,index)
    puts "invalid"
    index = collect_input
  end
  player_token = current_player(board)
  move(board, index, player_token)
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |element|
    if (element == "X") || (element == "O")
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      true
      return combo
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      true
      return combo
    end
  end
  false
end

def full?(board)
  board.each do |i|
    if (i != "X") && (i != "O")
      return false
    end
  end
  true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  elsif full?(board)
    true
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return "X"
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return "O"
    end
  end
  nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
