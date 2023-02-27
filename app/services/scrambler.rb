class Scrambler
  CATEGORIES = ['three', 'two']

  AXES_2 = ['X_2', 'Y_2', 'Z_2']

  X_2 = ['R', "R'", 'L', "L'", 'R2', 'L2']
  Y_2 = ['U', "U'", 'D', "D'", 'U2', 'D2']
  Z_2 = ['F', "F'", 'B', "B'", 'F2', 'B2']

  AXES_3 = ['X_3', 'Y_3', 'Z_3']

  X_3 = ['R', "R'", 'L', "L'", 'R2', 'L2']
  Y_3 = ['U', "U'", 'D', "D'", 'U2', 'D2']
  Z_3 = ['F', "F'", 'B', "B'", 'F2', 'B2']

  def two(scramble = '')
    moves = scramble.split(' ')

    return scramble.strip if moves.count == 9

    last_move = moves.last

    available_axes = if X_2.include?(last_move)
      AXES_2.excluding('X_2')
    elsif Y_2.include?(last_move)
      AXES_2.excluding('Y_2')
    elsif Z_2.include?(last_move)
      AXES_2.excluding('Z_2')
    else
      AXES_2
    end

    available_moves = available_axes.map do |axis|
      Scrambler.const_get(axis)
    end.flatten

    scramble = scramble + ' ' + available_moves.sample

    two(scramble)
  end

  def three(scramble = '')
    moves = scramble.split(' ')

    return scramble.strip if moves.count == 21

    last_move = moves.last

    available_axes = if X_3.include?(last_move)
      AXES_3.excluding('X_3')
    elsif Y_3.include?(last_move)
      AXES_3.excluding('Y_3')
    elsif Z_3.include?(last_move)
      AXES_3.excluding('Z_3')
    else
      AXES_3
    end

    available_moves = available_axes.map do |axis|
      Scrambler.const_get(axis)
    end.flatten

    scramble = scramble + ' ' + available_moves.sample

    three(scramble)
  end
end
