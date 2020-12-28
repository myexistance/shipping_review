class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score, :shipping_id
end
