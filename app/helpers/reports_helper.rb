module ReportsHelper
  
    #returns the number for the associated grade (assumes Labs are "Lab #" format)
    def lab_number(lab_grade)
      re = /(\d+)/
      match = re.match(lab_grade.assignment.name)
      return match[1].to_i
    end
    
    #returns the total lab grade for the student
    def lab_total_earned(student)
      total = 0
      student.lab_grades.each do |grade|
        if grade.value!=nil
          total+=grade.value
        end
      end
      return number_to_human(total, precision: 4, strip_insignificant_zeros: true)
    end
    
    #returns the total points earned by the student
    def grade_total_earned(student)
      total = 0
      student.grades.each do |grade|
        if grade.value!=nil
          total+=grade.value
        end
      end
      return number_to_human(total, precision: 4, strip_insignificant_zeros: true)
    end
    
    #points possible
    def grade_total_possible(student)
      total = 0
      student.grades.each do |grade|
        total+=grade.assignment.value
      end
      return total
    end
    
    #lab points possible
    def lab_total_possible(student)
      total = 0
      student.lab_grades.each do |grade|
        total+=grade.assignment.value
      end
      return total
    end
    
    #returns value or emdash latex symbol if nil
    def print_value(x)
      if(x==nil)
        return "---"
      else
        return number_to_human(x, precision: 4, strip_insignificant_zeros: true)
      end
    end
  end
  