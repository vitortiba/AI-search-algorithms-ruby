class UniformCostSearch
  OBJECTIVE_STATE = [[1, 2, 3], [4, 5, 6], [7, 8, 0]].freeze

  Node = Struct.new(:action, :parent, :cost, :depth, :state)

	attr_accessor :first_state

  def initialize(first_state)
    @first_state = first_state
  end

  def execute
    list = []
    list.push(Node.new(nil, nil, 0, 0, @first_state))

    while !list.empty? do
    	# Retira o primeiro elemento
      @node = list.shift
      p @node.state
      return { success: true, node: @node } if @node.state == OBJECTIVE_STATE
      list.push(next_options)
      # Ordena pelo custo
      list = list.flatten.compact.sort_by { |node| node.cost }
    end
    { success: false, node: nil }
  end

  private

  def next_options
    methods_array = ['go_up', 'go_down', 'go_right', 'go_left']
    actioner = Actioner.new(@node.dup)
    actioner.validate
    methods_array.map do |method|
      actioner.send(method)
    end
  end
end