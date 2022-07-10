require 'minitest/autorun'
require_relative '../lib/cli'
require 'pry'

class CLITest < Minitest::Test
  def setup
    @storage = Minitest::Mock.new
    @storage.expect :get_tasks, ['task1', 'task2', 'task3']
    @storage.expect :nil?, false

    @empty_storage = Minitest::Mock.new
    @empty_storage.expect :get_tasks, []
    @empty_storage.expect :nil?, true
  end

  def test_push_new_task
    cli = CLI.new(storage: @storage)
    options = {subcommand: 'push', main_input: 'new task'}
    cli.parse(options)
   
    assert_equal ['task1', 'task2', 'task3', 'new task'], cli.tasks
  end

  def test_push_new_task_on_empty_list
    cli = CLI.new(storage: @empty_storage)
    options = {subcommand: 'push', main_input: 'new task'}
    cli.parse(options)
   
    assert_equal ['new task'], cli.tasks
  end
  
  def test_unshift_new_task
    cli = CLI.new(storage: @storage)
    options = {subcommand: 'unshift', main_input: 'new task'}
    cli.parse(options)
   
    assert_equal ['new task', 'task1', 'task2', 'task3'], cli.tasks
  end

  def test_unshift_new_task_on_empty_list
    cli = CLI.new(storage: @empty_storage)
    options = {subcommand: 'push', main_input: 'new task'}
    cli.parse(options)
   
    assert_equal ['new task'], cli.tasks
  end

  def test_pop_new_task
    cli = CLI.new(storage: @storage)
    options = {subcommand: 'pop'}
    cli.parse(options)
   
    assert_equal ['task1', 'task2'], cli.tasks
  end

  def test_pop_new_task_on_empty_list
    cli = CLI.new(storage: @empty_storage)
    options = {subcommand: 'pop'}
    cli.parse(options)
   
    assert_equal [], cli.tasks
  end

  def test_shift_new_task
    cli = CLI.new(storage: @storage)
    options = {subcommand: 'shift'}
    cli.parse(options)
   
    assert_equal ['task2', 'task3'], cli.tasks
  end

  def test_shift_new_task_on_empty_list
    cli = CLI.new(storage: @empty_storage)
    options = {subcommand: 'pop'}
    cli.parse(options)
   
    assert_equal [], cli.tasks
  end
end
