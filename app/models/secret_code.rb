class SecretCode < ApplicationRecord
  belongs_to :user, required: false
end
