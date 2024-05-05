# frozen_string_literal: true
require 'forwardable'
require 'uri'

# BEGIN
class Url
  include Comparable
  extend Forwardable
  def_delegators :@url, :scheme, :host, :port

  def initialize(url)
    @url = URI.parse(url)
  end

  def query_params
    return Hash.new unless @url.query
    @url.query.split("&").to_h do |row|
      key, value = row.split("=")
      [key.to_sym, value]
    end
  end

  def query_param(key, default = nil)
    query_params.fetch(key, default)
  end

  def <=>(other)
    [scheme, host, port, query_params] <=> [other.scheme, other.host, other.port, other.query_params]
  end
end
# END
