class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy, :hide]
  # GET /quotations
  # GET /quotations.json
  def index
    
    #hide all quotation in session[:hide_id]
    if session[:hide_id].nil? 
      @quotations = Quotation.all
    else
      @quotations = Quotation.where.not(id: session[:hide_id])
    end
    
    #After filter by session[:hide_id], search by check in quote and author columns
    if !params[:search].blank?
      @quotations = @quotations.search(params[:search])
      @search = params[:search]
    end

    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @quotations }
      format.xml { render :xml => @quotations }
    end
  end

  def search
    @quotations = Quotation.where('quote LIKE ?', '%#{params[:q]}%')
    redirect_to :back
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
  end

  # GET /quotations/new
  def new
    @quotation = Quotation.new
  end

  # GET /quotations/1/edit
  def edit
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to @quotation, notice: 'Quotation was successfully created.' }
        format.json { render :show, status: :created, location: @quotation }
      else
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html { redirect_to @quotation, notice: 'Quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #add quotation_id to session[:hide_id]
  def hide
    if session[:hide_id].nil?
      session[:hide_id] = []
    end
    session[:hide_id].push(@quotation.id)
    redirect_to :back
  end

  #clear quotation_id in session[:hide_id]
  def erase
    session.delete(:hide_id)
    redirect_to :back
  end
  
  #get xml file from user and insert Quotation into database
  def upload
    #if want to check uploaded file is xml
    if File.extname(params[:xml_file].original_filename) != ".xml"
    end

    uploaded_xml_string = params[:xml_file].read
    quotations = Hash.from_xml(uploaded_xml_string)["quotations"]

    quotations.each do |quotation|
     #Not care if duplicate
      Quotation.create(
      	:quote => quotation["quote"],
        :author_name => quotation["author_name"],
        :category_id => quotation["category_id"])	
     
     #Check duplicate id 
     # if quotation["id"].nil? || Quotation.where(id: quotation["id"]).count == 0
     #   q = ActionController::Parameters.new(quotation)
     #   Quotation.create(quotation)
     # else
     #   Quotation.find(quotation["id"]).update_attributes(quotation) 
     # end
    end
    redirect_to :back, notice: 123
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quotation_params
      params.require(:quotation).permit(:quote, :author_name, :category_id)
    end
end
