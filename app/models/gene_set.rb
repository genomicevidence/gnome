class GeneSet < ActiveRecord::Base
  belongs_to :collection
  serialize :gene_ids
end
