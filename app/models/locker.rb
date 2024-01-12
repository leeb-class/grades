class Locker < ApplicationRecord

  
  #---Attributes------
  #  number (string)
  #  notes (string)
  #  kit (integer)
  
  #---Validations------
  #the locker has the lock integrated with it- not a seperate model
  validates :number, :presence=> true, :uniqueness=>true
  validates :serial, :presence=> true, :uniqueness=>true
  validates :combo, :presence=>true
  #---Class Methods----
  
  
end
