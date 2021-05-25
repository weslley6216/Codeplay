class Lesson < ApplicationRecord
  belongs_to :course
  validates :name, :content, :duration, presence: true
  validates :name, uniqueness: true
end
