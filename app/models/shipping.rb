class Shipping < ApplicationRecord
  has_many :reviews

  before_create :slugify
 #slugfy method to convert Uppercase to Lowercase
  def slugify
    self.slug = name.parameterize
  end

  def avg_score
    reviews.average(:score).to_f.round(2)
  end
end
