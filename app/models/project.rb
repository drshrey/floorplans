class Project < ApplicationRecord
  has_many :floorplans, dependent: :destroy
end
