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
    query_params[key] || default
  end

  def ==(other)
    @url.scheme == other.scheme &&
    @url.host == other.host &&
    @url.port == other.port &&
    query_params == other.query_params
  end
end
# END
