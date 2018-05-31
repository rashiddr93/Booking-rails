#
# User Model
#
# @author rashid
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :session_stores, dependent: :destroy

  def public_attributes
    attributes.slice('email', 'name', 'dob')
  end
end
