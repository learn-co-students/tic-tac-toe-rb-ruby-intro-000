def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n
         #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n
         #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end
def valid_move?(board, index)
  if index.between?(0, 8)
    if !position_taken?(board, index)
      true
    end
  else
    false
  end
end

def turn_count(board)
  counter = 0
  board.each do |value|
    if value == "O" || value == "X"
      counter += 1
    end
  end
  return counter
end
def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def turn(board)
  token = current_player(board)

  puts "Please enter 1-9:"
  input = gets.strip

  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    puts "Invalid number, try again!"
    turn(board)
  end
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
  # X O X
  # X X X
  # 0 X 0
  WIN_COMBINATIONS.each do |winblock|
    position_1 = board[winblock[0]]
    position_2 = board[winblock[1]]
    position_3 = board[winblock[2]]

    if (position_1 == "X") && (position_2 == "X") && (position_3 == "X")
      return winblock
    elsif (position_1 == "O") && (position_2 == "O") && (position_3 == "O")
      return winblock
    end
  end
  return false
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  if !won?(board)
    full?(board) ? true : false
  else
    false
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |winblock|
    position_1 = board[winblock[0]]
    position_2 = board[winblock[1]]
    position_3 = board[winblock[2]]

    if (position_1 == "X") && (position_2 == "X") && (position_3 == "X")
      return "X"
    elsif (position_1 == "O") && (position_2 == "O") && (position_3 == "O")
      return "O"
    end
  end
  return nil
end

def play(board)
  until won?(board) || over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
