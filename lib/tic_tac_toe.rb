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

def display_board(board)
  puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts ("-----------")
  puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts ("-----------")
  puts (" #{board[6]} | #{board[7]} | #{board[8]} ")
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  if board[position.to_i] != " "
    true
  else
    false
  end
end

def valid_move?(board, position)
  if
    position_taken?(board, position) or board[position].nil? or position.to_i < 0
    false
  else
    true
  end
end

def turn(board)
  move = true
  while move
    puts "Player #{current_player(board)}, where would you like to place your piece?"
    play = input_to_index(gets.strip)
      if valid_move?(board,play)
        board[play] = "#{current_player(board)}"
        move = false
      else
        puts "invalid"
    end
  end
end

def turn_count(board)
  board.select{|position| position != " "}.length
end

def current_player(board)
  if turn_count(board) % 2 == 0
    turn = "X"
  else
    turn = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect{|winning_combo| board[winning_combo[0]] == board[winning_combo[1]] && board[winning_combo[1]] == board[winning_combo[2]] && winning_combo.all? {|val| position_taken?(board, val)}}
end

def full?(board)
  board.all?{|value| value != " "}
end

def draw?(board)
  full?(board) and !won?(board)
end

def over?(board)
  draw?(board) or won?(board)
end

def winner(board)
  if !won?(board).nil?
     board[won?(board).first]
  end
end

def play(board)
  until full?(board) or won?(board)
    current_player(board)
    turn(board)
    display_board(board)
    full?(board)
    won?(board)
    draw?(board)
  end
  if won?(board)
      puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
      puts "Cat's Game!"
  end
end
