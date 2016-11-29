
class Knight
  attr_accessor :position, :possible_moves, :board, :parent

  def initialize(position)
  	@position = position
    @board = create_board
    @possible_moves = new_moves
    @parent = nil
  end

  def create_board
    board = []
    8.times do |x|
      8.times do |y|
        board << [x,y]
      end
    end
    return board
  end

  def new_moves
    x = @position[0]
    y = @position[1]
    moves = [[x-2,y-1],[x-1,y-2],[x+1,y-2],[x+2,y-1],[x+2,y+1],[x+1,y+2],[x-1,y+2],[x-2,y+1]]
    moves.select! do |move|
      move[0] >= 0 && move[0] <= 7 && move[1] >= 0 && move[1] <= 7
    end 
    moves
  end

  def knight_moves(start,finish)
  	if @board.include?(start) && @board.include?(finish)
  	  knight = Knight.new(start)
  	  queue = [knight]
  	  until queue[0].position == finish
  	  	prev_knight = queue.shift
  	    prev_knight.possible_moves.each do |move|
  	      knight = Knight.new(move)
  	      knight.parent = prev_knight
  	      queue << knight
  	    end
  	  end
  	  current_knight = queue[0]
  	  path = []
  	  until current_knight.parent == nil
  	  	path.unshift(current_knight.position)
  	  	current_knight = current_knight.parent
  	  end
  	  path.unshift(current_knight.position)
  	  puts "You made it in #{path.length-1} moves!. Here's your path:"
  	  path.each do |spot|
  	    print "#{spot}\n"
  	  end
  	end
  end
end



knight = Knight.new([0,0])

knight.knight_moves([1,4],[3,1])


