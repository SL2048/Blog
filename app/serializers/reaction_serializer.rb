class ReactionSerializer < ActiveModel::Serializer
  attributes :id, :reaction_type, :user
  
  def user
    {
      id: object.user.id,
      username: object.user.username,
      name: object.user.name
    }
  end
end
