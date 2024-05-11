# frozen_string_literal: true

require 'benchmark'

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    start = Time.now
    status, headers, response = @app.call(env)
    finish = Time.now
    diff = finish - start
    [status, headers.merge({ X_time: diff }), response]
    # END
  end
end
