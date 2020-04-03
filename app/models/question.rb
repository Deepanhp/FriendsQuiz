class Question < ApplicationRecord
	belongs_to :quiz
	has_many :options
	validates :questions, presence: true, length: {minimum: 3, maximum: 60}
	validates :answer, presence: true, length: {minimum: 3, maximum: 20}
	validates :score, presence: true
end