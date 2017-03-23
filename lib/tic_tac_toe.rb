# code your #valid_move? method here
def valid_move?(arr, idx)
  if (0..8).include?(idx) && !(position_taken?(arr, idx))
    return true
  end
  false
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(arr, idx)
  if arr[idx] == "X" || arr[idx] == "O"
    return true
  end
  false
end

def display_board(arr)
  puts " #{arr[0]} | #{arr[1]} | #{arr[2]} "
  puts "-----------"
  puts " #{arr[3]} | #{arr[4]} | #{arr[5]} "
  puts "-----------"
  puts " #{arr[6]} | #{arr[7]} | #{arr[8]} "
end

# code your input_to_index and move method here!
def input_to_index(num)
  (num.to_i) - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn(arr)
  puts "Please enter 1-9:"

  num = gets.strip

  idx = input_to_index(num)

  current_player = current_player(arr)

  if valid_move?(arr, idx)
    move(arr, idx, current_player)

    display_board(arr)
  else
    turn(arr)
  end
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [0, 4, 8]
]


def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    win_idx_1 = win_combination[0]
    win_idx_2 = win_combination[1]
    win_idx_3 = win_combination[2]

    position_1 = board[win_idx_1]
    position_2 = board[win_idx_2]
    position_3 = board[win_idx_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end

  false

end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  return true if !(won?(board)) && full?(board)
  false
end

def over?(board)
  return true if full?(board) || won?(board) || draw?(board)
  false
end

def winner(board)
  if won?(board)
    winning_index = won?(board)
    board[winning_index[0]]
  end

end

# define turn_count
def turn_count(arr)
  count = 0

  arr.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end

  count

end


def current_player(arr)
  turn_count(arr).even? ? "X" : "O"
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end

end

def winner(board)
  if won?(board)
    winning_index = won?(board)
    board[winning_index[0]]
  end

end
