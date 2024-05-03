# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def test_item_add
    stack1 = Stack.new([])
    stack2 = Stack.new([1])
    stack1.push!(1)
    assert { stack1.to_a == stack2.to_a }
  end

  def test_item_remove
    stack1 = Stack.new([1, 2, 3])
    stack2 = Stack.new([1, 2])
    stack1.pop!
    assert { stack1.to_a == stack2.to_a }
  end

  def test_clear
    stack = Stack.new([1, 2, 3])
    assert { stack.clear!.empty? == true }
  end

  def test_is_empty
    stack1 = Stack.new([])
    stack2 = Stack.new([1])
    assert { stack1.empty? == true }
    assert { stack2.empty? == false }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
