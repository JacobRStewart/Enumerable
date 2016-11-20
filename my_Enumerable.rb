module Enumerable

  def my_each
    i = 0
    while i < self.length do
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length do
      yield(self[i],i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    self.my_each do |item|
      if yield(item) then result << item end
    end
    result
  end

  def my_all?
    if block_given?
      self.my_each { |item| return false unless yield(item) }
    else
      self.my_each { |item| return false unless item }
    end
    true
  end

  def my_any?
    if block_given?
      self.my_each { |item| return true if yield(item) }
    else
      self.my_each { |item| return true if item }
    end
    false
  end

  def my_none?
    if block_given?
      self.my_each { |item| return false if yield(item) }
    else
      self.my_each { |item| return false if item}
    end
    true
  end

  def my_count(target = false)
    count = 0
    if block_given?
      self.my_each { |item| count += 1 if yield(item) }
    elsif target
      self.my_each { |item| count += 1 if item == target }
    else
      count = self.size
    end
    count
  end

  def my_map(proc)
    result = []
    if proc && block_given?
      self.my_each { |item| result << proc.call(item)}
    elsif proc && !block_given
      self.my_each { |item| resut << yield(item)}
    result
  end

  def my_inject(memo = self[0])
    self.my_each { |item| memo = yield(memo, item)}
    memo
  end
end
