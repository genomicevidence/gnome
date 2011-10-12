class GeneSet < ActiveRecord::Base
  belongs_to :collection
  serialize :gene_ids
  attr_accessor :p_value

  def overlapping_gene_ids(significant_gene_ids)
    gene_ids & significant_gene_ids
  end
end
