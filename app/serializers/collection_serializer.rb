class CollectionSerializer < ActiveModel::Serializer
  attributes :set_id, :condition, :status

  has_many :errors

  def errors
    return object.problems
  end

end
