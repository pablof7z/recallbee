class User < ActiveRecord::Base
  has_many :children
  include NewsletterSubscribable
  has_many :toys, through: :children
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      first_name: params['info']['first_name'],
      last_name: params['info']['last_name'],
      image: params['info']['image'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  private
end
