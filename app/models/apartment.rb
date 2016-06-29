class Apartment < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: lambda { |image| ActionController::Base.helpers.image_path('/legohouse.jpg') }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
