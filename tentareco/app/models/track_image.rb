class TrackImage < ApplicationRecord
  belongs_to :track
  has_one_attached :image 

  attribute :new_image

  validates :new_image, presence: { on: :create }

  validate if: :new_image do
    if new_image.respond_to?(:content_type)
      unless new_image.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_image, :invalid_content_type)
      end
    else
      errors.add(:new_image, :invalid)
    end
  end
  
  before_save do
    #self.registered_image = new_image if new_image
    self.image = new_image if new_image
  end

end
