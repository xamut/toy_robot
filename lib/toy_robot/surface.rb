module ToyRobot
  class Surface
    class WrongLength < StandardError; end
    class WrongWidth < StandardError; end

    TRANSITION_MATRIX = {
      NORTH: [0,  1],
      EAST:  [1,  0],
      SOUTH: [0, -1],
      WEST:  [-1, 0]
    }

    def initialize(length, width)
      if length <= 0 || length > 100
        raise WrongLength, 'Wrong length, must be in range 1 to 100'
      end

      if width <= 0 || width > 100
        raise WrongWidth, 'Wrong width, must be in range 1 to 100'
      end

      @length = length
      @width  = width
    end

    def placement_is_allowed?(x, y)
      x >= 0 && x <= @length && y >= 0 && y <= @width
    end

    def step_from_is_allowed?(x, y, facing)
      coordinates = coordinates_next_step_from(x, y, facing)
      placement_is_allowed?(*coordinates)
    end

    def coordinates_next_step_from(x, y, facing)
      facing_key = facing.dup.upcase.to_sym
      shift_x, shift_y = TRANSITION_MATRIX[facing_key]
      [x + shift_x, y + shift_y]
    end

    def facings
      @facings ||= TRANSITION_MATRIX.keys.dup.map(&:to_s)
    end
  end
end
