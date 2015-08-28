class Minesweeper

  def initialize(diff)
    @diff = diff
    bombs = 0
    height = 0
    width = 0

    case diff
    when "easy"
      height = 9
      width = 9
      bombs = 10
    when "intermediate"
      height = 16
      width = 16
      bombs = 40
    when "hard"
      height = 16
      width = 30
      bombs = 99
    end

    @grid = Array.new(height) {Array.new(width,Tile.new)}
    populate
  end

  def reveal(pos)
    x,y = pos
    raise "Game Over!" if grid[x][y].bomb
    grid[x][y].revealed = true
  end

  def flag(pos)
    grid[x][y].flagged = true
  end

  def populate
    case diff
    when "easy"
    when "intermediate"
    when "hard"
    end

  end

  def adjacent_bombs(pos)
  end





end

class Tile
  def initialize(bomb = false, revealed = false, flagged = false)
    @bomb = bomb
    @revealed = revealed
    @flagged = flagged
  end
end
