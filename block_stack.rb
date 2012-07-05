class BlockStack

  class Element

    attr_accessor :default_args

    def initialize element, &block
      @block = block
      @next_element = element
    end

    def peek *args
      @next_element.default_args = args unless @next_element.nil?
      @next_element.instance_exec *args, &@block
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
