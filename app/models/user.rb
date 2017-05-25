class User < ActiveRecord::Base
  has_many :campagnes

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of     :email, :nom, :prenom
  validates_presence_of     :encrypted_password
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false

  def prenom_nom
    "#{prenom} #{nom}"
  end

end
