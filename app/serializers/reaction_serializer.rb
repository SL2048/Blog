class ReactionSerializer < ActiveModel::Serializer
  attributes :id, :reaction_type
  has_one :user
end
