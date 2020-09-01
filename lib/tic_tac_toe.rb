require 'pry'

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
    user_input.chomp.to_i-1
  end
  
  def move(board, position, player_token)
    board[position] = player_token
  end
  
  def position_taken?(board, position)
    !(board[position] != "X" && board[position] != "O")
  end
  
  def valid_move?(board, position)
    position.between?(0,8) && !position_taken?(board, position)
  end
  
  def turn(board)
      puts "Please enter 1–9"
      user_input = gets
      position = input_to_index(user_input)
      if valid_move?(board, position)
        player_token = current_player(board)
        move(board, position, player_token)
        display_board(board)
      else
        turn(board)
      end
  end
  
  def turn_count(board)
    taken_positions_array = board.select do |position|
        position == "X" || position == "O"
    end
    taken_positions_array.length
  end
  
  def current_player(board)
    if turn_count(board) % 2 == 0
      player_token = "X"
    elsif turn_count(board) % 2 != 0
      player_token = "O"
    end
  end
  
  def won?(board)
    winning_output = WIN_COMBINATIONS.each do |winning_streak|
     win_X = winning_streak.all? do |position|
      character = board[position] 
      character == "X"
     end
     win_O = winning_streak.all? do |position|
      character = board[position] 
      character == "O"
     end
     if win_X || win_O
      return winning_streak
     end
    end
    if winning_output == WIN_COMBINATIONS
      return false
    end
  end
  
  def full?(board)
    board.all? do |position|
      position == "X" || position == "O"
    end
  end

  def draw?(board)
    full?(board) && !won?(board)
  end

  def over?(board)
    won?(board) || draw?(board) || full?(board)
  end

  def winner(board)
    if won?(board) != false
      board[won?(board).first]
    end
  end

  def play(board)
    turn_count(board)
    current_player(board)
    turn(board)
    over?(board)
    winner(board)
  end


