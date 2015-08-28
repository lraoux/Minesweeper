class Minesweeper

  CHECK = [[-1,0], [-1,-1], [-1,1], [0,1], [0,-1], [1,-1], [1,0], [1,1]]
  attr_accessor :height, :width, :bombs, :grid

  def initialize(diff)
    @diff = diff
    @bombs = 0
    @height = 0
    @width = 0

    case diff
    when "easy"
      @height = 9
      @width = 9
      @bombs = 10
    when "intermediate"
      @height = 16
      @width = 16
      @bombs = 40
    when "hard"
      @height = 16
      @width = 30
      @bombs = 99
    end

    @grid = Array.new(height) { Array.new(width) { Tile.new } }
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
    bombs.times do
      grid[rand(width)][rand(height)].bomb = true
    end


  end

  def adjacent_bombs(pos)

    num_bombs = 0

    CHECK.each do |el|
      num_bombs += 1 if grid[pos[0 + el[0]][1 + el[1]]].bomb
    end

    num_bombs
  end





end

class Tile
  attr_accessor :bomb, :revealed, :flagged, :adj_bombs

  def initialize(bomb = false, revealed = false, flagged = false, adj_bombs = 0)
    @bomb = bomb
    @revealed = revealed
    @flagged = flagged
    @adj_bombs = adj_bombs
  end
end
