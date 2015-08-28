require 'byebug'

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

    @grid = Array.new(width) { Array.new(height) { Tile.new } }
    populate
  end

  def reveal(pos)
    x, y = pos
    raise "Game Over!" if grid[x][y].bomb
    grid[x][y].revealed = true unless grid[x][y].flagged
  end

  def flag(pos)
    grid[x][y].flagged = true
  end

  def populate

    bombs.times do
      x,y = [rand(width), rand(height)]
      tile = grid[x][y]
      tile.bomb = true
    end
    grid.each_index do |row|
      grid[row].each_index do |col|
        grid[row][col].position = [row,col]
      end
    end
  end




  def display
    grid.each_index do |row|
      grid[row].each_index do |tile|
        if grid[row][tile].revealed
          if grid[row][tile].bomb
            print "*"
          elsif grid[row][tile].flagged
            print "P"
          else
            print adjacent_bombs(grid[row][tile].position)
          end
        else
          print "o"
        end
      end
      puts
    end
  end

  def adjacent_bombs(pos)
    num_bombs = 0

    CHECK.each do |el|
      num_bombs += 1 if grid[pos[0] + el[0]] [pos[1] + el[1]].bomb

    end

    num_bombs
  end

  def click(pos)
    reveal(pos)
     if adjacent_bombs(pos) == 0
       cands = [self]
       until cands.empty?
         CHECK.each do |el|
           cands.shift
           tile = grid[pos[0 + el[0]]][1 + el[1]]
           cands.push(tile) unless tile.bomb
           reveal(tile.position) unless tile.flagged
         end
       end
     end
   end
 end

class Tile
  attr_accessor :bomb, :revealed, :flagged, :adj_bombs, :position

  def initialize(bomb = false, revealed = false, flagged = false, adj_bombs = 0, position = [0,0])
    @bomb = bomb
    @revealed = revealed
    @flagged = flagged
    @adj_bombs = adj_bombs
    @position = position
  end
end
