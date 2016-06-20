struct Time
  def to_json(io)
    io << '"'
    to_s io
    io << '"'
  end
end
