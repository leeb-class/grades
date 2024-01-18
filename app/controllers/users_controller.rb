class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    # GET /users
    # GET /users.json
    def index
      @users = User.all
    end
  
    # GET /users/1
    # GET /users/1.json
    def show
    end
  
    # GET /users/new
    def new
      @user = User.new
    end
  
    # GET /users/1/edit
    def edit
    end
  
    # POST /users
    # POST /users.json
    def create
      #only admins can create users
      unless current_user.admin?
        render nothing: true, status: :unauthorized and return
      end
      @user = User.new(user_params)
      @user.admin=true if(params[:user][:admin]=="1")
      respond_to do |format|
        if @user.save
          format.html { redirect_to :users, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      #admins can change any account and users can change their own account
      unless current_user.admin? or @user.id==current_user.id
        render nothing: true, status: :unauthorized and return
      end
      #don't require the user to change password
      if user_params[:password]=="" and user_params[:password_confirmation]==""
        filtered_params=user_params.except(:password,:password_confirmation)
      else
        filtered_params=user_params
      end
      #only an admin can change 'admin' status, and can't change his own status
      if current_user.admin? and @user.id != current_user.id
        @user.admin= (params[:user][:admin]=="1" ? true : false)
      end
      respond_to do |format|
        if @user.update(filtered_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      #only admins can remove users. can't remove yourself
      if (not current_user.admin?) or (@user.id == current_user.id)
        render nothing: true, status: :unauthorized and return
      end
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
  end
  