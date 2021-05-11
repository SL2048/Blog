class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body
  belongs_to :user
  has_many :reactions, serializer: ReactionSerializer
end
