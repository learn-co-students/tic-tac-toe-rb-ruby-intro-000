WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal Left to Right
  [2,4,6]  # Diagonal Right to Left
    ]

    def display_board (board = " ")
      puts " #{board[0]} | #{board[1]} | #{board[2]} "
      puts "-----------"
      puts " #{board[3]} | #{board[4]} | #{board[5]} "
      puts "-----------"
      puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index (input)
      input_to_index = input.to_i - 1
    end

    def move(board, index, current_player)
      board[index] = current_player
    end

    def position_taken?(board, index)
      board[index] != " " && board[index] != ""
    end

    def valid_move?(board, index)
      index.between?(0,8) && !position_taken?(board, index)
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

    def turn_count (board)
        count = 0
        board.each do | board_position |
          if board_position == "X" || board_position == "O"
                count += 1
          end
        end
      count
    end

    def current_player (board)
      if turn_count(board) % 2 == 0
        "X"
      else
        "O"
      end
    end

    def won?(board)
      WIN_COMBINATIONS.find do |win_combination|

        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

          if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
            return win_combination
          end #if end
        end #loop end
    end #def end

def full? (board)
  board.all? do |counter|
  counter == "X" || counter == "O"
  end #loop end
end #def end

def draw? (board)
  if won?(board) == nil && full?(board) == true
    return true
  end
end

def over? (board)
  won?(board) || draw?(board) || full?(board)
end

def winner (board)
  if winning_counter = won?(board)
    board[winning_counter[1]]
  else
    nil
  end
end

def play (board)
  turn = 0
  until over?(board)
        turn(board)
        turn += 1
  end #until end

    if draw?(board)
      puts "Cat's Game!"
    elsif won?(board)
      puts "Congratulations #{winner(board)}!"
    end #if end
end #def end
