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
  def turn(board, player_token)
      puts "Please enter 1–9"
      user_input = gets
      position = input_to_index(user_input)
      if valid_move?(board, position)
        move(board, position, player_token)
        display_board(board, player_token)
      else
        turn(board)
      end
  end
  def turn_count(board)
    taken_positions_array = board.select do |position|
        position == "X" || position == "O"
    end
    num_of_turns = taken_positions_array.length
    return num_of_turns
  end