class AppsController < ApplicationController
  require "open-uri"
  require "nokogiri"
  
  def index
    get_applist
    html_scraping
    # student = Student.new("男", "175cm", "優しい")
  end

private

    def get_applist
      Applist.destroy_all
      
      uri = "http://api.steampowered.com/ISteamApps/GetAppList/v2"
      charset = nil
      html = open(uri) do |h|
        charset = h.charset
        h.read
      end
      doc=eval(html)
      @applist=doc[:applist][:apps][4..6]#5個目からアプリ
      Applist.create(@applist)
    end

    def html_scraping
      @applist=Applist.order("created_at ASC")
      @applist.each do |app|
        url = "https://store.steampowered.com/app/#{app.appid}"
        doc = Nokogiri::HTML(open(url),nil,"utf-8")

        @content=[]
        nokogiri_src(doc,@content,".game_header_image_full")
        @content=doc.css(".game_description_snippet").text
        @content<<doc.css("#userReviews .game_review_summary").text
        @content<<doc.css(".date").text
        @content<<doc.css("#developers_list").text

        @screenshot_hd=[]
        nokogiri_key(doc,@screenshot_hd,:href,".highlight_screenshot_link")
        @screenshot_poor=[]
        nokogiri_src(doc,@screenshot_poor,".highlight_strip_screenshot img")
        @movie=[]
        nokogiri_key(doc,@movie,:"data-webm-hd-source",".highlight_movie")

        @tag=doc.css(".glance_tags_label").text
        nokogiri_text(doc,@tag,".app_tag")
        
        @price=[]
        nokogiri_key(doc,@price,:"data-price-final","#game_area_purchase .game_purchase_price")
        nokogiri_key(doc,@price,:"data-price-final","#game_area_purchase .game_purchase_discount")
        nokogiri_text(doc,@price,"#game_area_purchase .discount_pct")
        nokogiri_text(doc,@price,"#game_area_purchase .discount_original_price")
        nokogiri_text(doc,@price,"#game_area_purchase .discount_final_price")
      end
    end

    def nokogiri_src(doc,variable,selector)
      doc.css(selector).each do |value|
        variable<<value.attribute("src").value
      end
    end

    def nokogiri_key(doc,variable,key,selector)
      doc.css(selector).each do |value|
        variable<<value[key]
      end
    end

    def nokogiri_text(doc,variable,selector)
      doc.css(selector).each do |value|
        variable<<value.text
      end
    end

    # def gender
    #   @gender
    # end


end
