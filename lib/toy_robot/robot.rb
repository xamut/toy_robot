module ToyRobot
  class Robot
    attr_reader :x, :y, :facing, :surface

    def initialize(interface, surface)
      @interface = interface
      @surface = surface
      @x = nil
      @y = nil
      @facing = nil
    end

    def start
    end

    def place(x, y, facing)
      if surface.placement_is_allowed?(x, y)
        @x = x
        @y = y
        @facing = facing
      else
        puts "Placement is not allowed!"
      end
    end

    def move
      if placed? && surface.step_from_is_allowed?(x, y, facing)
        @x, @y = surface.coordinates_next_step_from(x, y, facing)
      end
    end

    def left
      return unless placed?
      @facing = surface.facings.rotate(surface.facings.index(facing) - 1).first
    end

    def right
      return unless placed?
      @facing = surface.facings.rotate(surface.facings.index(facing) + 1).first
    end

    def report
      return unless placed?
      puts [x, y, facing].join(", ")
    end

    private

    def placed?
      x && y && facing
    end
  end
end
