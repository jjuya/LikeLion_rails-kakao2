require 'nokogiri'
require 'open-uri'



res = open("http://m.cgv.co.kr/WebAPP/MovieV4/movieList.aspx?mtype=now&iPage=1")
    
doc = Nokogiri::HTML(res)

movies = []

# puts doc
for i in (1..10)
    #contents > div.wrap-movie-chart > div.sect-movie-chart > ol:nth-child(2) > li:nth-child(1) > div.box-contents > a > strong
    #contents > div.wrap-movie-chart > div.sect-movie-chart > ol:nth-child(2) > li:nth-child(2) > div.box-contents > a > strong
    #contents > div.wrap-movie-chart > div.sect-movie-chart > ol:nth-child(2) > li:nth-child(3) > div.box-contents > a > strong
    #contents > div.wrap-movie-chart > div.sect-movie-chart > ol:nth-child(3) > li:nth-child(1) > div.box-contents > a > strong
    #contents > div.wrap-movie-chart > div.sect-movie-chart > ol:nth-child(3) > li:nth-child(4) > div.box-contents > a > strong
	cssText = "#ContainerView > div.main_movie_list.clsAjaxList > div.mm_list_item.event_seq_80068 > a:nth-child(" + i.to_s + ") > div > div.tit_area > strong"
	movie = (i).to_s + "위 " + doc.css(cssText).text
	movies << (movie + "/n")
end

puts movies