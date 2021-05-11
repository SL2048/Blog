class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :updated_at
end
