class Assignment < ApplicationRecord
 #---Associations-----
  has_many :grades, dependent: :destroy
  has_many :students, -> { uniq }, through: :grades
   
  #---Attributes------
  #  name (string)
  #  description (string)
  #  abbreviation (string)
  #  value (boolean)
  
  
  #---Validations------
  validates :name, :presence=> true, :uniqueness=>true
  validates :abbreviation, :presence=> true, :uniqueness=>true
  validates :value, numericality: {greater_than: 0}
  #---Class Methods----
  
end
