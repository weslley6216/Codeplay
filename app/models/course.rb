class Course < ApplicationRecord
  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true

  belongs_to :instructor
  has_many :lessons, dependent: :destroy

  has_many :enrollments, dependent: :nullify
  has_many :users, through: :enrollment

  scope :available, -> { where(enrollment_deadline: Date.current..) }
end
