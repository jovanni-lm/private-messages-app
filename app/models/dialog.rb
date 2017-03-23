class Dialog < ApplicationRecord
  belongs_to :sender_id
  belongs_to :recipient_id
end
