class Instructor < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_one_attached :profile_picture
  has_many :courses
end
