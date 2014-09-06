require 'open-uri'
class AbcController < ApplicationController
	def index
		@imgs , @links = fetchABC
	end
	
	def fetchABC
		imgs = []
		links = []
		page = Nokogiri::HTML(open("http://www.abc.com"))
		items = page.css('#secondaryContent .imageContainer')
		for i in 1..items.length
			imgs << "http://static.east.abc.go.com/service/image/ratio/id/" + JSON.parse( items[i-1].css('img').first["data-properties"])["image"]["src"] + "/dim/" + (i==1 ? "660.22x9" : "320.64x31") + ".jpg"
 			links << items[i-1].css('a').first["href"]
		end
		return imgs, links
	end	
end

