class Venue < ActiveRecord::Base
  has_and_belongs_to_many(:bands)
  validates(:name, :presence => true)
  before_save(:capitalize)

  private
  define_method(:capitalize) do
    self.name=(name().capitalize())
  end
end
