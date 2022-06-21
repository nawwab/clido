class CLI
  attr_reader :tasks, :storage

  def initialize(storage: TaskStorage.new)
    @storage = storage
    @tasks = []
  end

  def parse(options)
    unless storage.nil?
      @tasks =  [*storage.get_tasks]
    end

    case options[:subcommand]
    when 'add'
      @tasks = [*@tasks, options[:main_input]]
    when 'remove'
      case options[:main_input]
      when 'all'
        @tasks = []
      else
        position = (options[:main_input] || @tasks.length - 1).to_i
        @tasks = @tasks.select.with_index do |task, idx|
          idx != position
        end
      end
    end
  end
end
