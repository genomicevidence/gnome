class Genome < ActiveRecord::Base
  belongs_to :dataset, :counter_cache => true
  has_many :variants
  has_many :summaries
end
