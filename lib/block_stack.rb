class BlockStack

  class Element

    attr_accessor :default_args

    def initialize element, &block
      @block = block
      @next_element = element
    end

    def with_peek_methods(instance, *default_args)
      next_element = @next_element

      instance.instance_eval do 

        @peek_next_element = next_element
        @peek_default_args = default_args

        def peek *a
          @peek_next_element.peek *a
        end
         
        def peek!
          @peek_next_element.peek *@peek_default_args
        end
      end

      result = yield

      instance.instance_eval do
        #undef peek 
        #undef peek!
      end

      result
    end

    def peek *args
      with_peek_methods(eval("self", @block.binding), *args)do
        @block.call *args
      end
    end

    def peek!
      peek *default_args
    end

  end

  def initialize
    @blocks = nil
  end

  def push &block
    @blocks = Element.new(@blocks, &block)
  end

  def << block
    push &block
  end

  def pop
    @blocks.pop
  end

  def peek *args
    @blocks.peek *args
  end

  def empty?
    @blocks.nil?
  end

end
