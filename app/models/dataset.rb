class Dataset < ActiveRecord::Base
  belongs_to :project
  has_many :genomes
  has_many :variants
  has_many :summaries, :through => :genomes

  validates_associated :project
  validates_presence_of :category, :file
  validates_inclusion_of :category, :in => %w( case control)

  mount_uploader :file, FileUploader
  process_in_background :file
end
