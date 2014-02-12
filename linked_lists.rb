require 'benchmark'

Node = Struct.new(:next, :value)

class List

	attr_reader :last, :first

	def initialize(start_values = [])
		start_values.each{ |x| add(x)}
	end

	def add(node_element)
		set_last(Node.new(node_element))
	end

	def add_at(index, element)
		add_after(at(index), element)
	end

	def add_after(item, element)
		element = Node.new(element)
		element.next = item.next if item.next
		item.next = element
	end

	def at(index)
		i=0
		each{ |x| return x if i== index; i+=1}
	end

	def each(&block)
		i = first
		while i
			yield i
			i = i.next
		end
	end

	def each_value(&block)
		each_in_box{|a| yield a.value}
	end

	def set_last(node)
		if first
			@last.next = node
			@last = node
		else
			@first = @last = node
		end
	end


end


####driver code ####

a = List.new((1..10000).to_a)
time = Benchmark.measure do
	15.times do
		el = a.at(rand(1000))
		10000.times do 
			a.add_after(el, "test")
		end
	end
end

print time











