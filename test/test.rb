require 'minitest/autorun'
require 'block_stack'

class TestBlockStack < MiniTest::Unit::TestCase
  def setup
    @blocks = BlockStack.new
  end

  def test_that_empty_stack_is_empty
    assert_equal true, @blocks.empty?
  end

  def test_that_stack_is_not_empty_after_pushing_a_block
    @blocks.push {}
    assert_equal false, @blocks.empty?
  end

  def test_that_stack_chain_is_executed_correctly_wit_no_params
    @blocks.push { 'middle' }
    @blocks.push { "<#{peek}>" }
    @blocks.push { "{#{peek!}}" }

    assert_equal '{<middle>}', @blocks.peek
  end

  def test_that_stack_chain_is_executed_correctly_with_param
    @blocks.push { |a| a }
    @blocks.push { peek! }
    @blocks.push { |a| "<#{peek(a) + 'dle'}>" }
    @blocks.push { "{#{peek!}}" }

    assert_equal '{<middle>}', @blocks.peek('mid')
  end

  def test_that_stack_is_not_empty_after_insertion
    @blocks << proc do 
      'test'
    end

    assert_equal false, @blocks.empty?
    assert_equal 'test', @blocks.peek
  end

  def dummy
    'dummy'
  end

  def test_that_instance_methods_are_available
    @blocks.push { dummy }

    assert_equal 'dummy', @blocks.peek
  end
end
