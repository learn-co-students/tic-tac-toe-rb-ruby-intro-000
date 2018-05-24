def play(board)
  until over?(board)
    turn(board)
    if draw?(board)
      break
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  #input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

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

#def move(board, index, current_player = "X")
def move(board, index, current_player)
  board[index] = current_player
  #board[index] = current_player(board)
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "X" or space == "O"
      turn += 1
    end
  end
  turn
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

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

def won?(board)
  WIN_COMBINATIONS.select do |row|
    if position_taken?(board, row[0]) && board[row[0]] == board[row[1]] && board[row[1]] == board[row[2]]
      return row
    end
  end
  return false
end

def full?(board)
  WIN_COMBINATIONS.select do |row|
    row.select do |element|
      if !position_taken?(board, element)
        return false
      end
    end
  end
true
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board).is_a?(Array)
    return board[won?(board)[0]]
  else
    return nil
  end
end
