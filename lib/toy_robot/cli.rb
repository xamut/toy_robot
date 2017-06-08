require "thor"

module ToyRobot
  class CLI < Thor
    def self.manual_path
      File.join(File.dirname(__FILE__), "../../assets/manual.txt")
    end

    desc "start", "Start toy robot simulator in interactive mode by default."

    long_desc File.read(manual_path)

    option :file,
      aliases: "-f",
      desc: "Read commands from file."

    option :length,
      aliases: "-l",
      desc: "Length of surface in range of 1 to 100",
      default: 5,
      type: :numeric

    option :width,
      aliases: "-w",
      desc: "Width of surface in range of 1 to 100",
      default: 5,
      type: :numeric

    def start
      file = options[:file]
      interface = if file
                    Interfaces::FileInterface.new(file)
                  else
                    Interfaces::InteractiveInterface.new
                  end

      surface = ToyRobot::Surface.new(options[:length], options[:width])
      ToyRobot::Robot.new(interface, surface).start
    rescue => e
      puts e.message
    end
  end
end
