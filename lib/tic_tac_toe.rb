WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    pos1 = combination[0]
    pos2 = combination[1]
    pos3 = combination[2]

    if((board[pos1] == "X" && board[pos2] == "X" && board[pos3] == "X") ||
        (board[pos1] == "O" && board[pos2] == "O" && board[pos3] == "O"))
      return combination
    end
  end
  return nil
end

def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  combination = won?(board)
  return combination == nil ? nil : board[combination[0]]
end

def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip

  index = input_to_index(input)

  until valid_move?(board, index)
    puts "Enter valid number"
    input = gets.strip
    index = input_to_index(input)
  end

  move(board, index, current_player(board))
  display_board(board)

end

def valid_move?(board, index)
  if !index.between?(0, 8)
    return false
  end

  value = board[index]
  if(value == nil)
    value = ""
  end

  return value.strip == ""
end

def move(board, index, token)
  board[index] = token
end

def input_to_index(input)
  return input.to_i - 1
end

def turn_count(board)
  count = 0
  board.each do |value|
    if(value != " " && value != "" && value != nil)
      count += 1
    end
  end

  return count
end

def position_taken?(board, index)
  value = board[index]

  if(value == nil)
    value = ""
  end

  return value.strip != ""
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)

  until over?(board) do
    turn(board)
  end

  combination = won?(board)
  if combination
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
