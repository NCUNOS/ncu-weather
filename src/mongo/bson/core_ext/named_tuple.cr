struct NamedTuple
  def to_bson(bson = BSON.new)
    each do |k, v|
      k = k.to_s
      v = v.to_s if v.is_a? ::Symbol
      case v
      when Array
        bson.append_array(k) do |appender, child|
          v.to_bson(child)
        end
      when Hash
        bson.append_document(k) do |child|
          v.to_bson(child)
        end
      else
        bson[k] = v
      end
    end
    bson
  end
end
