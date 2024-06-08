# frozen_string_literal: true

class BulletinsController < ApplicationController
  # BEGIN
  def index
    @bulletins = Bulletin.all
  end

  def show
    # published
    @bulletin = Bulletin.find(params[:id])
  end
  # END
end
