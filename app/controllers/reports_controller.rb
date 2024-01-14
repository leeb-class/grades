class ReportsController < ApplicationController
    before_action :authenticate_user!
  
    # GET /reports/students
    def students
      #returns a pdf for each student
      @students = Student.all
      if(params[:single_sided]=="1")
        render :students_single_sided, :layout=>'latex', formats: [:pdf] and return
      else  
        render :students, :layout=>'latex', formats: [:pdf] and return
      end
    end
    
    # GET /reports/master
    def master
      #returns a pdf for the class
      @students_by_name = Student.order('LOWER(last_name)').all
      @students_by_grade = Student.all.sort_by do |student|
        student.total_grade
      end
      @students_by_grade = @students_by_grade.reverse
      render :layout=>'latex_table', formats: [:pdf]
    end
    
end
