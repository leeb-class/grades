class Student < ApplicationRecord
    #---Associations-----
    has_many :grades, dependent: :destroy
    has_many :assignments, -> { distinct }, through: :grades

    #---Attributes------
    #  athena (string)
    #  first_name (string)
    #  last_name (string)
    
    #---Validations------
    validates :last_name, :presence=> true
    validates :athena, :presence=> true, :uniqueness=>true
    #---Class Methods----
    
    def full_name
      "#{self.first_name} #{self.last_name}"
    end
    
    def total_grade 
      total = 0
      self.grades.each do |grade|
        if(grade.value!=nil)
          total+=grade.value
        end
      end
      return total
    end
    
    ####String matching to seperate grades into labs and miscs
    def lab_grades
      re = /^Lab (\d+)$/
      lab_grades = []
      self.grades.each do |grade|
        if(re.match(grade.assignment.name))
          lab_grades.append(grade)
        end
      end
      return lab_grades
    end
    
    def misc_grades
      re = /^Lab (\d+)$/
      misc_grades = []
      self.grades.each do |grade|
        unless(re.match(grade.assignment.name))
          misc_grades.append(grade)
        end
      end
      return misc_grades
    end
    
    
  end