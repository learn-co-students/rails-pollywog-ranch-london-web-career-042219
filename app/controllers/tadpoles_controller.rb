class TadpolesController < ApplicationController
  before_action :set_tadpole, only: [:show, :edit, :update, :destroy, :metamorphose]

  # add your metamorphose action here

  #get /tadpoles
  def index
    @tadpoles = Tadpole.all
  end

  #get /tadpoles/1
  def show
  end

  #get /tadpoles/new (form page)
  def new
    @frog = Frog.find(set_frog)
    @tadpole = Tadpole.new
  end

  #get /tadpoles/new (form page)
  def edit
    @frog = @tadpole.frog
  end

  #post /tadpoles 
  def create
    @tadpole = Tadpole.new(tadpole_params)
    respond_to do |format|
      if @tadpole.save
        format.html { redirect_to @tadpole, notice: 'Tadpole was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tadpole.update(tadpole_params)
        format.html { redirect_to @tadpole, notice: 'Tadpole was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tadpole.destroy
    respond_to do |format|
      format.html { redirect_to tadpoles_url, notice: 'Tadpole was successfully destroyed.' }
    end
  end

  def metamorphose 

    @tadpole = set_tadpole #sets to the current frog

    new_frog = Frog.create( #creates the frog based on the tadpole information
      name:@tadpole.name,
      color:@tadpole.color,
      pond:Frog.find(@tadpole.frog_id).pond
      )

    @tadpole.destroy #deletes that tadpole

    redirect_to frog_path(new_frog) #redirects to the new frogs page

  
  end 

  private
    def set_tadpole #finds the frog with the current id and sets it.
      @tadpole = Tadpole.find(params[:id])
    end

    def set_frog
      @frog = Frog.find(params[:frog_id])
    end

    def tadpole_params
      params.require(:tadpole).permit(:name, :color, :frog_id)
    end
end
