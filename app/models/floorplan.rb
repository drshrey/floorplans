class Floorplan < ApplicationRecord
  belongs_to :project
  has_many :versioned_files, dependent: :destroy
end
