class DividebyzeroController < ApplicationController

# GET /divideyzero
# GET /divideyzero.json 
  def index
   
  end

 def show
   if params[:second]
   @data1 = params[:first]
   @data2 = params[:second]
   begin
     logger.info "About Divide by zero exceptions"
     @data3 = @data1.to_i / @data2.to_i
   rescue => e
     @data3 = 0
     #render :text => "About Divide by zero exception"
     #render :text => e.message
     render :text => "<h1>"+ "About to divide by 0" + "</h1>" +e.backtrace.inspect
   end
   #parmas[:result] = @data3
   end
 end
   #redirect_to :action=>"index" #show the home page itself
 #redirect_to :action=>"dividebyzero#index" #show the home page itself
end
