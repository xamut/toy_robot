module ToyRobot
  class Interface
    NEW_LINE = "\n".freeze

    attr_reader :input

    def initialize(input)
      @input  = input
    end

    def commands
      input.each_line do |line|
        normalized_string = normalize_string(line)
        command, *args = parse_command(normalized_string)
        next if command.nil?
        yield [command, *args].compact
      end
    end

    private

    def normalize_string(string)
      string.strip
    end

    def parse_command(string)
      case string
      when /\APLACE (\d+,\d+,[[:upper:]]+)\z/
        args = $1.split(',')
        [:place, *args]
      when /\AMOVE\z/
        :move
      when /\ALEFT\z/
        :left
      when /\ARIGHT\z/
        :right
      when /\AREPORT\z/
        :report
      end
    end
  end
end
