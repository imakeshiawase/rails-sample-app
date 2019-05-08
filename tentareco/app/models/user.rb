class User < ApplicationRecord
  has_secure_password

  has_many :tracks, dependent: :destroy

  has_many :claps, dependent: :destroy
  has_many :clapped_tracks, through: :claps, source: :track

  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  validates :name,
    presence: true,
    format: {
      with: /\A[A-Za-z][A-Za-z0-9]*\z/,
      allow_blank:true,
      message: :invalid_user_name
    },
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }
  
  validates :full_name, 
    presence: true,
    length: { maximum: 20 }

  validates :email, email: { allow_blank: true }

  attr_accessor :current_password
  validates :password, presence: {if: :current_password}

  validate if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end
  end

  before_save do 
    if new_profile_picture
      self.profile_picture = new_profile_picture
    else remove_profile_picture
      self.profile_picture.purge
    end
  end

  def can_clap_for?(track)
    track && track.artist != self && !claps.exists?(track_id: track.id)
  end

  class << self
    def search(query)
      rel = order(created_at: :desc)
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?", "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
