class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  enum status: { unchecked: 0, checked: 1 }
  belongs_to :user
end
