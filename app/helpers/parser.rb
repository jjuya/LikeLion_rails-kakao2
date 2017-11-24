require 'nokogiri'
require 'open-uri'

module Parser
    class Movie
        def rank_movie
            res = open("http://movie.naver.com/movie/sdb/rank/rmovie.nhn")
    
            doc = Nokogiri::HTML(res)
        
            movies = []
            
            # puts doc
            for i in (2..11)
                #old_content > table > tbody > tr:nth-child(2) > td.title > div > a
            	cssText = "#old_content > table > tbody > tr:nth-child(" + i.to_s + ") > td.title > div > a"
            	movie = (i-1).to_s + "위 " + doc.css(cssText).text
            	movies << movie
            end
            
            return movies
        end
        
        def rank_ticketing
            res = open("http://movie.naver.com/movie/sdb/rank/rreserve.nhn")
    
            doc = Nokogiri::HTML(res)
        
            movies = []
            
            # puts doc
            for i in (2..11)
                #boxoffice-section > div > div > ul > div.ranking.card.grid-1.hei-2.top-0.left-0 > div > ol > li:nth-child(19) > a
                #boxoffice-section > div > div > ul > div.ranking.card.grid-1.hei-2.top-0.left-0 > div > ol > li.item.rank2 > a
                
                #old_content > table > tbody > tr:nth-child(2) > td.title > div > a
                #old_content > table > tbody > tr:nth-child(2) > td.reserve_per.ar
            	cssTitle = "#old_content > table > tbody > tr:nth-child(" + i.to_s + ") > td.title > div > a"
            	cssTicket = "#old_content > table > tbody > tr:nth-child(" + i.to_s + ") > td.reserve_per.ar"
            	movie = (i - 1).to_s + "위 " + doc.css(cssTitle).text
                ticket = doc.css(cssTicket).text
            	movies << movie + ticket
            end
            
            return movies
        end
    end
end