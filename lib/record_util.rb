
class RecordUtil
  
  def self.group2_to_h(record)
    record.each_with_object({}) do |((first, second), value), result|
      result[first] ||= {} #if nil then equal
      result[first][second] = value
    end
  end

  def self.group3_to_h(record)
    record.each_with_object({}) do |((first, second, third), value), result|
      result[first] ||= {}
      result[first][second] ||= {}
      result[first][second][third] = value
    end
  end

end
