require "thor"

module ToyRobot
  class CLI < Thor
    def self.manual_path
      File.join(File.dirname(__FILE__), "../../assets/manual.txt")
    end

    desc "start", "Start toy robot simulator in interactive mode by default."
    long_desc File.read(manual_path)
    option :file, aliases: %w(-f), desc: "Read commands from file."

    def start
      if file = options[:file]
        Interfaces::FileInterface.new(file)
      else
        Interfaces::InteractiveInterface.new
      end
    end
  end
end
