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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index] == " " || board[index] == "" || board[index].nil?)
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    puts "Wrong move."
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  return counter += board.count("X") + board.count("O")
end

def current_player(board)
  if turn_count(board) == 0 || turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
   win_index_0 = win_combination[0]
   win_index_1 = win_combination[1]
   win_index_2 = win_combination[2]

   if board[win_index_0] == "X" && board[win_index_1] == "X" && board[win_index_2] == "X"
     return win_combination
   elsif board[win_index_0] == "O" && board[win_index_1] == "O" && board[win_index_2] == "O"
     return win_combination
   end
 end
end

def full?(board)
  board.all? { |i| i != " " }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
   win_index_0 = win_combination[0]
   win_index_1 = win_combination[1]
   win_index_2 = win_combination[2]

   if board[win_index_0] == "X" && board[win_index_1] == "X" && board[win_index_2] == "X"
     return "X"
   elsif board[win_index_0] == "O" && board[win_index_1] == "O" && board[win_index_2] == "O"
     return "O"
   elsif !won?(board)
     return nil
   end
 end
end

def play(board)
  while !over?(board)
    turn(board)
  end

    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
  end
end
