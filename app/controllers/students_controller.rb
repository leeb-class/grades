class StudentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_student, only: [:show, :edit, :update, :destroy]
  
    respond_to :json, :html
    # GET /student
    # GET /students.json
    def index
      @students = Student.all.order(last_name: :asc)
      respond_with @students
    end
  
    # GET /students/1
    # GET /students/1.json
    def show
    end
  
    # GET /students/new
    def new
      @student = Student.new
    end
  
    # GET /students/1/edit
    def edit
    end
  
    # POST /students
    # POST /students.json
    def create
      @student = Student.new(student_params)
      Grade.build_all
      respond_to do |format|
        if @student.save
          format.html { redirect_to @student, notice: 'Student was successfully created.' }
          format.json { render :show, status: :created, location: @student }
        else
          format.html { render :new }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end
    
    # POST /students/bulk_add.json
    def bulk_add
      #only admins can do this
      unless current_user.admin? 
        render nothing: true, status: :unauthorized and return
      end
      params[:students].each do |student_params|
        student = Student.new(student_params.permit(:first_name, :last_name, :athena))
        unless student.save
          puts student.errors.full_messages
          render json: Student.all, status: :unprocessable_entity and return
        end
      end
      Grade.build_all
      render json: Student.all
    end
  
    # POST /students/bulk_remove.json
    def bulk_remove
      #only admins can do this
      unless current_user.admin? 
        render nothing: true, status: :unauthorized and return
      end
      params[:students].each do |student_params|
        student = Student.find_by_athena(student_params[:athena])
        unless student
          render json: Student.all, status: :unprocessable_entity
        end
        student.destroy
      end
      Grade.build_all
      render json: Student.all
    end
    
    # PATCH/PUT /students/1
    # PATCH/PUT /students/1.json
    def update
      respond_to do |format|
        if @student.update(student_params)
          format.html { redirect_to @student, notice: 'Student was successfully updated.' }
          format.json { render :show, status: :ok, location: @student }
        else
          format.html { render :edit }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /students/1
    # DELETE /students/1.json
    def destroy
      @student.destroy
      Grade.build_all
      respond_to do |format|
        format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_student
        @student = Student.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def student_params
        params.require(:student).permit(:first_name, :last_name, :athena)
      end
  end
  