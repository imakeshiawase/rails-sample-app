class Clap < ApplicationRecord
  belongs_to :user
  belongs_to :track

  validate do
    unless user && user.can_clap_for?(track)
      errors.add(:base, :invalid)
    end
  end
end
