class Promotion
  class AbstractMethodError < StandardError; end
  
  def apply(items)
    raise AbstractMethodError, 'The #apply method must be implemented in subclasses'
  end
end