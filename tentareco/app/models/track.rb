class Track < ApplicationRecord
  belongs_to :artist, class_name: "User", foreign_key: "user_id"
  has_many :images, class_name: "TrackImage"

  has_many :claps, dependent: :destroy
  has_many :clappers, through: :claps, source: :user

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
end
