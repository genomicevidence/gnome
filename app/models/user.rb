class User < ActiveRecord::Base
  has_many :projects, :dependent => :delete_all

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at, :as => :admin

  validates :email, :format => { :with => /\.edu$/, :message => "must end with .edu" }
end
