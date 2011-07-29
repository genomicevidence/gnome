class Project < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  validates_associated :user
  validates_presence_of :title, :scenario
  validates_inclusion_of :scenario, :in => %w( case_only case_and_control  family healthy )

  def self.scenarios
    %w( case_only case_and_control  family healthy )
  end
end
