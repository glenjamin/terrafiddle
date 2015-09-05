# Terrafiddle v0.1.0
# http://github.com/glenjamin/terrafiddle

class << self
  def resource(type, name, attributes)
    $resource ||= begin
      autohash = lambda do
        Hash.new { |h, k| h[k] = autohash.call }
      end
      autohash.call
    end

    $resource[type][name] = attributes
  end
end

at_exit do
  require 'json'
  puts JSON.pretty_generate({ resource: $resource })
end
