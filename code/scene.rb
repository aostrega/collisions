require 'quadtree'

class Scene
  attr_accessor :things, :width, :height
  attr_reader :box_count

  def initialize
    @width = 512
    @height = 512
    @things = []
    @tree = Quadtree.new(0, 0, @width, @height)
    @box_count = 0

    20.times { add_box }
  end

  def update(game, elapsed)
    if game.keyboard.pressing? :equals
      add_box
    elsif game.keyboard.pressing? :minus
      remove_box
    end

    @tree.things = @things
    @things.each { |t| t.update(game, @things, elapsed) }
  end

  def draw(display)
    @things.each { |t| t.draw(display) }

    @tree.draw(display)

    display.stroke_color = Color[10, 10, 10]
    display.stroke_width = 3
    display.stroke_rectangle(0, 0, @width, @height)
  end

  def add_box
    things << Box.new(@width * rand, @height * rand)
    @box_count += 1
  end

  def remove_box
    @box_count -= 1 unless things.shift.nil?
  end
end
