require 'minitest/autorun'
require_relative '../lib/cli'
require 'pry'

class CLITest < Minitest::Test
  def test_add_new_tasks
    storage = Minitest::Mock.new
    storage.expect :get_tasks, []
    storage.expect :nil?, false

    cli = CLI.new(storage: storage)
    options = {subcommand: 'add', main_input: 'new task'}
    cli.parse(options)
   
    assert_equal ['new task'], cli.tasks
  end

  def test_add_new_tasks_on_last_index
    storage = Minitest::Mock.new
    storage.expect :get_tasks, ['task1', 'task2']
    storage.expect :nil?, false

    cli = CLI.new(storage: storage)
    options = {subcommand: 'add', main_input: 'new task'}
    cli.parse(options)
    
    assert_equal ['task1', 'task2', 'new task'], cli.tasks
  end

  def test_remove_tasks_on_last_index
    storage = Minitest::Mock.new
    storage.expect :get_tasks, ['task1', 'task2']
    storage.expect :nil?, false

    cli = CLI.new(storage: storage)
    options = {subcommand: 'remove'}
    cli.parse(options)
    
    assert_equal ['task1'], cli.tasks
  end

  def test_remove_tasks_on_specified_position
    storage = Minitest::Mock.new
    storage.expect :get_tasks, ['task1', 'task2', 'task3']
    storage.expect :nil?, false

    cli = CLI.new(storage: storage)
    options = {subcommand: 'remove', main_input: '1'}
    cli.parse(options)
    
    assert_equal ['task1', 'task3'], cli.tasks
  end

  def test_remove_all
    storage = Minitest::Mock.new
    storage.expect :get_tasks, ['task1', 'task2', 'task3']
    storage.expect :nil?, false

    cli = CLI.new(storage: storage)
    options = {subcommand: 'remove', main_input: 'all'}
    cli.parse(options)
    
    assert_equal [], cli.tasks
  end
end
