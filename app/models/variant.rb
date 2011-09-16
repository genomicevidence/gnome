class Variant < ActiveRecord::Base
  belongs_to :genome
  belongs_to :dataset
end
