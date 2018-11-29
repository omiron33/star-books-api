class LibrarySerializer < ActiveModel::Serializer
  attributes :timestamp, :satellite_id

  has_many :collections

  def satellite_id
    return object.id
  end
  
end
