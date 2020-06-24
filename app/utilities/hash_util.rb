# frozen_string_literal: true

class HashUtil

  def self.nested_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_value(a.last,key) }
      r
    end
  end

end