class Dataset < ActiveRecord::Base
  belongs_to :project

  validates_associated :project
  validates_presence_of :category, :file
  validates_inclusion_of :category, :in => %w( case control)

  mount_uploader :file, FileUploader
end
