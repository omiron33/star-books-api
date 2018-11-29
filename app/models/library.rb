class Library < ApplicationRecord
    has_many :collections, dependent: :destroy
    has_many :problems, through: :collections
end
