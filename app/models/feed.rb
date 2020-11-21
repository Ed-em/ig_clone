class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :post, presence: true
  validates :image, presence: true
  belongs_to :user
end
