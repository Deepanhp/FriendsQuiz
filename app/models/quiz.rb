class Quiz < ApplicationRecord
	has_and_belongs_to_many :questions, :dependent => :destroy
	has_many :quiz_categories
	has_many :submissions, :dependent => :destroy
  has_many :categories, through: :quiz_categories
	validates :name, uniqueness: true, presence: true, length: {minimum: 3}, allow_blank: false
end