# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)
    # Why the response is an array?
    response = response[0]
    response += "\n#{Digest::SHA256.hexdigest(response)}"
    # headers['Content-Length'] = response.bytesize.to_s
    [status, headers, [response]]
    # END
  end
end
