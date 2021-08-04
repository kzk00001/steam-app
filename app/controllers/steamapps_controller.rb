class SteamappsController < ApplicationController
  require "open-uri"
  require "nokogiri"
  
  def index
    #リストを取得して保存
    App.destroy_all
    uri = "http://api.steampowered.com/ISteamApps/GetAppList/v2"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    doc=eval(html)
    @applist=doc[:applist][:apps][4..7]#5個目からアプリ
    App.create(@applist)#rails db:reset

    # リストを読み出してスクレイピング
    applist=App.order("created_at ASC")
    applist.each do |app|
      uri = "https://store.steampowered.com/app/#{app.appid}"
      doc = Nokogiri::HTML(open(uri),nil,"utf-8")
      #画像のURL
      @app_info=app.appid
      @app_info<<app.name

      @image_hd=[]
      doc.css(".highlight_screenshot_link").each do |url|
        @image_hd<<url[:href]
      end

      @image_low=[]
      doc.css(".highlight_strip_screenshot img").each do |url|
        @image_low<<url.attribute("src").value
      end

      @movie=[]
      doc.css(".highlight_movie").each do |url|
        @movie<<url[:"data-webm-hd-source"]
      end

      @content=[]
      doc.css(".game_header_image_full").each do |url|
        @content<<url.attribute("src").value
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
end
