class AppsController < ApplicationController
  require "open-uri"
  require "nokogiri"
  
  def index
    get_applist
    html_scraping

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

        # @image_hd=[]
        # doc.css(".highlight_screenshot_link").each do |url|
        #   @image_hd<<url[:href]
        # end

        @image_poor=[]
        doc.css(".highlight_strip_screenshot img").each do |url|
          @image_poor<<url.attribute("src").value.delete("?").sub!(/t=.*/m, "")
        end

        nokogiri_a(doc,@image_hd,:href,".highlight_screenshot_link")

        @movie=[]
        doc.css(".highlight_movie").each do |url|
          @movie<<url[:"data-webm-hd-source"]
        end

        @content=[]
        doc.css(".game_header_image_full").each do |url|
          @content<<url.attribute("src").value.delete("?").sub!(/t=.*/m, "")
        end
        @content<<doc.css(".game_description_snippet").text
        @content<<doc.css("#userReviews .game_review_summary").text
        @content<<doc.css(".date").text
        @content<<doc.css("#developers_list").text

        @tag=doc.css(".glance_tags_label").text
        doc.css(".app_tag").each do |url|
          @tag<<url.text
        end
        
        doc.css("#game_area_purchase .game_purchase_price").each do |value|
          @price=value[:"data-price-final"]
        end
        doc.css("#game_area_purchase .game_purchase_discount").each do |value|
          @price=value[:"data-price-final"]
        end
        doc.css("#game_area_purchase .discount_pct").each do |value|
          @price<<value.text
        end
        doc.css("#game_area_purchase .discount_original_price").each do |value|
          @price<<value.text
        end
        doc.css("#game_area_purchase .discount_final_price").each do |value|
          @price<<value.text
        end
      end
    end

    def nokogiri_a(doc,variable,key,selector)
      variable=[]
      doc.css(selector).each do |value|
        variable<<value[key]
      end
    end



end
