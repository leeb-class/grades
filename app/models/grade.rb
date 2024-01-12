class Grade < ApplicationRecord
    #---Associations-----
  belongs_to :student
  belongs_to :assignment 
  
  #---Attributes------
  #  value (positive float)
  
  #---Validations------
  validates :value, numericality: {greater_than_or_equal_to: 0}, allow_nil: true
  
  #---Class Methods----
  def self.build_all
    #make sure every student has a grade for every assignment
    Student.all.each do |student|
      Assignment.all.each do |assignment|
        match = false
        #find the matching assignment for this student
        student.assignments.each do |my_assignment|
          if my_assignment.id==assignment.id
            match = true
            break
          end
        end
        if match == false
          student.assignments << assignment
        end
      end
      student.save!
    end
  end
end
