class Genome < ActiveRecord::Base
  belongs_to :dataset
  has_many :variants
end
