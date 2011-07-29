class Project < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :datasets, :dependent => :delete_all

  validates_associated :user, :datasets
  validates_presence_of :title, :scenario
  validates_inclusion_of :scenario, :in => %w( case_only case_and_control  family healthy )

  accepts_nested_attributes_for :datasets, :limit => 2

  def self.scenarios
    %w( case_only case_and_control  family healthy )
  end
end
