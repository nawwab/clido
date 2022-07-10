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
    when 'push'
      @tasks = [*@tasks, options[:main_input]]
    when 'unshift'
      @tasks = [options[:main_input], *@tasks]
    when 'pop'
      @tasks = @tasks.slice(0, @tasks.length - 1) || []
    when 'shift'
      @tasks = @tasks.slice(1, @tasks.length) || []
    end
  end
end
