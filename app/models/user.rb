class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:twitter]
  has_many :apartments
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }, :default_url => "/lego.jpg"
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + "@twitter.com"
      user.password = Devise.friendly_token[0,20]
    end
  end
end
