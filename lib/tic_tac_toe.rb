
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

board = [ " ", " ", " ",
          " ", " ", " ",
          " ", " ", " "]


def display_board(board)
  puts(" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts("-----------")
  puts(" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts("-----------")
  puts(" #{board[6]} | #{board[7]} | #{board[8]} ")
end

def input_to_index(input)
  index = input.to_i - 1
end

def player_move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  (!position_taken?(board,index)) && index >= 0 && index <= 8
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    player_move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
   number = 0
   board.each do |cell|
     if cell == "X" || cell == "O"
       number += 1
     end  # of if
   end # of .each
   number
 end # of def

def current_player(board)
  turn_count(board)%2 == 0 ? player = "X" : player = "O"
end

def won?(board)
  is_there_a_winner = false
  WIN_COMBINATIONS.each do | win |
    we_have_a_winner = win.all? do |cell|
      board[cell] == "X"
    end  # of all? do
    if we_have_a_winner
      is_there_a_winner = true
    else
      we_have_a_winner = win.all? do |cell|
        board[cell] == "O"
      end  # of all? do
      if we_have_a_winner
        is_there_a_winner = true
      end # of else if
    end  #of if
  end # of each do
  is_there_a_winner
end  # of def


def full?(board)
  is_full = true
  for i in (0..8)
    if board[i] != "X" && board[i] != "O"
      is_full = false
    end
  end
  is_full
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
    winning_player = nil
    WIN_COMBINATIONS.each do | win |
    we_have_a_winner = win.all? do |cell|
      board[cell] == "X"
    end  # of all? do
    if we_have_a_winner
      winning_player = "X"
    else
      we_have_a_winner = win.all? do |cell|
        board[cell] == "O"
      end  # of all? do
      if we_have_a_winner
        winning_player = "O"
      end # of else if
    end  #of if
  end # of each do
  winning_player
end


def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    if draw?(board)
      puts "Cat's Game!"
    end
  end
end
