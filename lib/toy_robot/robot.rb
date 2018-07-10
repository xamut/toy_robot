module ToyRobot
  class Robot
    attr_reader :x, :y, :facing, :surface, :interface

    def initialize(interface, surface)
      @interface = interface
      @surface = surface
      @x = nil
      @y = nil
      @facing = nil
    end

    def start
      interface.commands do |command|
        send(*command)
      end
    end

    def place(x, y, facing)
      x = x.to_i
      y = y.to_i

      if surface.placement_is_allowed?(x, y, facing)
        @x = x
        @y = y
        @facing = facing
      end
    end

    def move
      if placed? && surface.step_from_is_allowed?(x, y, facing)
        @x, @y = surface.coordinates_next_step_from(x, y, facing)
      end
    end

    def left
      return unless placed?
      @facing = surface.facing_from(facing, :to_left)
    end

    def right
      return unless placed?
      @facing = surface.facing_from(facing, :to_right)
    end

    def report
      return unless placed?
      puts [x, y, facing].join(",")
    end

    private

    def placed?
      x && y && facing
    end
  end
end
