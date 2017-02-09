WIN_COMBINATIONS =  [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def play(board)
  until over?(board)
    turn(board)
  end
  puts winner(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"
end

def display_board(board)
  time = 0
  while time < 3
    puts " #{board[time * 3]} | #{board[time * 3 + 1]} | #{board[time * 3 + 2]} "
    if time < 2
      puts "-----------"
    end
    time += 1
  end
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, charactor)
  board[index] = charactor
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8)
    if board[index] == " " || board[index] == "" || !board[index]
      true
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |move|
    if move == "X" || move == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    state1 = board[combination[0]]
    state2 = board[combination[1]]
    state3 = board[combination[2]]
    return combination if position_taken?(board, combination[0]) && state1 == state2 && state2 == state3
  end
  false
end

def full?(board)
  !(board.include?(" ") || board.include?(nil))
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  (combination = won?(board)) ? board[combination[0]] : nil
end
