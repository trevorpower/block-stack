require './block_stack'

stack = BlockStack.new

simple = 'test'

stack.push do |a|
  simple + a + simple
end

stack.push do |*a|
  "<#{peek!}>"
end

stack.push do |*a|
  "{#{peek!}}"
end

puts stack.peek('==')
