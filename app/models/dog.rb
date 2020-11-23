class Dog < ApplicationRecord
  belongs_to :user
  attachment :image
end
