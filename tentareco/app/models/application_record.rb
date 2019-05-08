class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #ALLOWED_CONTENT_TYPES = %q{image/jpeg image/png image/gif image/bmp}
  #ALLOWED_CONTENT_TYPES = %w(image/jpeg image/png image/gif image/bmp)
  ALLOWED_CONTENT_TYPES = ["image/jpeg", "image/png", "image/gif", "image/bmp"]
end
