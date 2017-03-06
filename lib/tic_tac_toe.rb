WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(array, index, value)
    array[index] = value
  end

  def position_taken?(board, index)
    if (board[index] == " ") || (board[index] == "")
      return false
    end
    if board[index] == "X" || board[index] == "O"
      return true
    end
    if board[index] == nil
      return false
    end
  end

  def valid_move?(board, index)
    if position_taken?(board, index) == false && index.between?(0, 8) == true
      return true
    else
      return false
    end
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index) == true
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def turn_count(board)
    counter = 0
    board.each do |move|
      if move == "X" || move == "O"
        counter += 1
      end
      counter
    end
    return counter
  end

  def current_player(board)
    if turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?(board)
        WIN_COMBINATIONS.each do |win_combo|
            win_index_1 = win_combo[0]
            win_index_2 = win_combo[1]
            win_index_3 = win_combo[2]

            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]

            if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
              return win_combo
            end
        end
        return false
  end

  def full?(board)
    board.all? do |position|
      position == "X" || position == "O"
    end
  end

  def draw?(board)
    # if won?(board) == false && full?(board) == true
    #   return true
    # else
    #   return false
    # end
    !won?(board) && full?(board)
  end

  def over?(board)
    won?(board) || draw?(board)
  end

  def winner(board)
    if won?(board)
      return board[won?(board)[0]]
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
