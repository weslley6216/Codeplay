class Instructor < ApplicationRecord
  validates :name, :email, presence: { message: 'não pode ficar em branco' }
  validates :email, uniqueness: { message: 'O email informado já está em uso' }
end
