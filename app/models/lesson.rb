class Lesson < ApplicationRecord
  belongs_to :course
  validates :name, :content, presence: true
  validates :name, uniqueness: true
end
