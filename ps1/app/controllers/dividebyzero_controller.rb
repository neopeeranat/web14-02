class DividebyzeroController < ApplicationController

# GET /divideyzero
# GET /divideyzero.json 
  def index
   #@data1 = ""
   #@data2 = ""
   if params[:second]
   @data1 = params[:first]
   @data2 = params[:second]
   @e_msgs = nil
   begin
     logger.info "About Divide by zero exceptions"
     @data3 = @data1.to_i / @data2.to_i
   rescue => e
     @data3 = nil
     @e_msgs = e.backtrace
     @e_class = e.class
     #render :text => "<h1>"+ "About to divide by 0 exception" + "</h1>" + "<font size =2>" + e.backtrace.inspect + "</font>"
   end
   #parmas[:result] = @data3
   end
  end

   #redirect_to :action=>"index" #show the home page itself
 #redirect_to :action=>"dividebyzero#index" #show the home page itself
end
