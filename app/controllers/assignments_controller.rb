class AssignmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_assignment, only: [:show, :edit, :update, :destroy, 
        :edit_grades, :update_grades, :save_grades]
  
    # GET /assignment
    # GET /assignments.json
    def index
      @assignments = Assignment.all
    end
  
    # GET /assignments/1
    # GET /assignments/1.json
    def show
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "show.html.erb"
        end
      end
    end
  
    # GET /assignments/new
    def new
      @assignment = Assignment.new
    end
  
    # GET /assignments/1/edit
    def edit
    end
  
    # GET /assignments/1/edit_grades
    def edit_grades
      respond_to do |format|
        format.html {render :edit_grades}
        format.pdf { render :layout=>'latex', formats: [:pdf]}
      end
    end
    
    # GET /assignments/1/update_grades
    def update_grades
      respond_to do |format|
        format.html {render :update_grades}
        format.pdf { render :layout=>'latex', formats: [:pdf]}
      end
    end
    
    # POST /assignments/1/save_grades
    def save_grades
      grade_data = params[:grades]
      grade_data.each do |id,value|
        grade = Grade.find(id)
        grade.value = value
        grade.save!
      end
      flash.notice = 'Assignment successfully updated'
      flash.keep(:notice)
      render text: "ok"
    end
    
    # POST /assignments
    # POST /assignments.json
    def create
      unless current_user.admin?
        render nothing: true, status: :unauthorized and return
      end
      @assignment = Assignment.new(assignment_params)
      @assignment.save
      Grade.build_all
      respond_to do |format|
        if @assignment.valid?
          format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
          format.json { render :show, status: :created, location: @assignment }
        else
          format.html { render :new }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /assignments/1
    # PATCH/PUT /assignments/1.json
    def update
      unless current_user.admin?
        render nothing: true, status: :unauthorized and return
      end
      respond_to do |format|
        if @assignment.update(assignment_params)
          format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
          format.json { render :show, status: :ok, location: @assignment }
        else
          format.html { render :edit }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /assignments/1
    # DELETE /assignments/1.json
    def destroy
      unless current_user.admin?
        render nothing: true, status: :unauthorized and return
      end
      @assignment.destroy
      Grade.build_all
      respond_to do |format|
        format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_assignment
        @assignment = Assignment.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def assignment_params
        params.require(:assignment).permit(:name, :description, :value, :abbreviation)
      end
  end
  