class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :name
end
