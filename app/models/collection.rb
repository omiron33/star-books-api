class Collection < ApplicationRecord
  belongs_to :library
  has_many :problems, dependent: :destroy
end
