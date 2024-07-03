# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  status      :string
#  creator     :string
#  performer   :string
#  completed   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  before_validation :set_defaults
  validates :name, :creator, :status, presence: true

  private

  def set_defaults
    'new' if status.blank?
  end
end
