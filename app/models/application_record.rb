class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  attachment :profile_image
end
