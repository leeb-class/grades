class LockersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_locker, only: [:show, :edit, :update, :destroy]
    respond_to :json, :html
  
    # GET /lockers
    # GET /lockers.json
    def index
      @lockers = Locker.all
      respond_to do |format|
        format.pdf {render :layout=>'latex_table', formats: [:pdf]}
        format.html { render :index}
        format.json {render json: @lockers}
      end
     # respond_with @lockers
    end
  
    # GET /lockers/1
    # GET /lockers/1.json
    def show
    end
  
    # GET /lockers/new
    def new
      @locker = Locker.new
    end
  
    # GET /lockers/1/edit
    def edit
    end
  
    # POST /lockers
    # POST /lockers.json
    def create
      @locker = Locker.new(locker_params)
  
      respond_to do |format|
        if @locker.save
          format.html { redirect_to @locker, notice: 'Locker was successfully created.' }
          format.json { render :show, status: :created, location: @locker }
        else
          format.html { render :new }
          format.json { render json: @locker.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /lockers/1
    # PATCH/PUT /lockers/1.json
    def update
      respond_to do |format|
        if @locker.update(locker_params)
          format.html { redirect_to @locker, notice: 'Locker was successfully updated.' }
          format.json { render :show, status: :ok, location: @locker }
        else
          format.html { render :edit }
          format.json { render json: @locker.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /lockers/1
    # DELETE /lockers/1.json
    def destroy
      @locker.destroy
      respond_to do |format|
        format.html { redirect_to lockers_url, notice: 'Locker was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    
    
    # PUT /lockers/bulk_update.json
    def bulk_update
      Locker.destroy_all
      params[:lockers].each do |locker|
        l = Locker.new(locker.permit(:number, :serial, :kit, :comment, :combo, :notes))
        unless l.valid?
          render json: {locker: l, errors: l.errors.full_messages}, status: :bad_request
          return
        end
        l.save!
      end
      render json: Locker.all
    end
    
    # PUT /lockers/rotate.json
    def rotate
      #rotate all lockers up by 1
      lockers = Locker.all
      last_serial = lockers.last.serial
      last_combo = lockers.last.combo
      i=lockers.length-1
      while i>0
        lockers[i].update_attribute(:serial,lockers[i-1].serial)
        lockers[i].update_attribute(:combo,lockers[i-1].combo)
        i-=1
      end
      lockers[0].update_attribute(:serial, last_serial)
      lockers[0].update_attribute(:combo, last_combo)
      lockers.each do |locker|
        puts locker.combo
        #locker.save!
      end
      
      redirect_to :lockers, notice: 'Locks rotated by +1'
    end
    
    # GET /lockers/checkout
    def checkout
      @lockers = Locker.all
      @contents = Item.all
      render :layout=>'latex', formats: [:pdf]
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_locker
        @locker = Locker.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def locker_params
        params.require(:locker).permit(:number, :serial, :kit, :comment, :combo, :notes)
      end
  end
  