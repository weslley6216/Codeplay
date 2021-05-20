class Course < ApplicationRecord
  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true

  belongs_to :instructor
end
