class GradesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_grade, only: [:edit, :update]
  
    # GET /grades/1/edit
    def edit
    end
    
    # GET /grades/1
    # GET /grades/1.json
    def show
    end
    
    
    # PATCH/PUT /grades/1
    # PATCH/PUT /grades/1.json
    def update
      respond_to do |format|
        if @grade.update(grade_params)
          format.html { redirect_to @grade.assignment, notice: 'Grade was successfully updated.' }
          format.json { render :show, status: :ok, location: @grade }
        else
          format.html { render :edit }
          format.json { render json: @grade.errors, status: :unprocessable_entity }
        end
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_grade
        @grade = Grade.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def grade_params
        params.require(:grade).permit(:value)
      end
      
  end
  