class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  enum reaction_type: {
    like: "like",
    smile: "smile",
    love: "love",
    angry: "angry",
    sad: "sad"
  }

end
