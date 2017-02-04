
def turn_count(board)
  turns = 0
  board.each {|space|
if space == "X" || space == "O"
  turns += 1
end
  }
  return turns
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  elsif turn_count(board).even?
    return "X"
  else
    return nil
  end

end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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
  win_combination = []
WIN_COMBINATIONS.each {|array|
  win_index_1 = array[0]
  win_index_2 = array[1]
  win_index_3 = array[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    win_combination << win_index_1
    win_combination << win_index_2
    win_combination << win_index_3

  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    win_combination << win_index_1
    win_combination << win_index_2
    win_combination << win_index_3
  end
}
if win_combination != []
  return win_combination
else
  return false
end
end

def full?(board)
  if board.all?{|i| i == "X" || i == "O"}
    return true
  else
    return false
  end
end

def draw?(board)
if full?(board) && !(won?(board))
  return true
else
  return false
end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if draw?(board)
    return nil
  elsif
    array = won?(board)
    if board[array[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end

end
