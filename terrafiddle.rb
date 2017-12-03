# Terrafiddle v0.2.0
# http://github.com/glenjamin/terrafiddle

class << self
  def autohash
    Hash.new { |h, k| h[k] = autohash }
  end

  def resource(type, name, attributes)
    $resource ||= autohash
    $resource[type][name] = attributes
  end

  def output(name, value)
    $output ||= autohash
    $output[name] = {value: value}
  end
end

at_exit do
  require 'json'
  data = {}
  data[:resource] = $resource if $resource
  data[:output] = $output if $output
  puts JSON.pretty_generate(data)
end
