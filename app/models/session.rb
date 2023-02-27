class Session < ApplicationRecord
  has_many :records, dependent: :destroy

  enum category: { _333: 0, _222: 1 }
end
