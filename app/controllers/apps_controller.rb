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
      @applist=doc[:applist][:apps][4..5]#5個目からアプリ
      Applist.create(@applist)
    end

    def html_scraping
      @applist=Applist.order("created_at ASC")
      @applist.each do |app|
          url = "https://store.steampowered.com/app/#{app.appid}"
          doc = Nokogiri::HTML(open(url),nil,"utf-8")

          # unless app.name.include?("Pack")

          @content={}
          nokogiri_src(doc,@content,:header_image_url,".game_header_image_full")
          nokogiri_text(doc,@content,:description,".game_description_snippet")
          nokogiri_text(doc,@content,:review_summary,"#userReviews .game_review_summary")
          nokogiri_text(doc,@content,:release_date,".date")
          nokogiri_text(doc,@content,:developer,"#developers_list")
          @content[:applist_id]=app.id
          Content.create(@content)

          screenshot_url=[]
          nokogiri_target(doc,screenshot_url,[],".highlight_screenshot_link",:href)
          @screenshot_hd={}
          @screenshot_hd[:url]=screenshot_url
          @screenshot_hd[:applist_id]=app.id
          ScreenshotHd.create(@screenshot_hd)

          screenshot_url=[]
          nokogiri_src(doc,screenshot_url,[],".highlight_strip_screenshot img")
          @screenshot_poor={}
          @screenshot_poor[:url]=screenshot_url
          @screenshot_poor[:applist_id]=app.id
          ScreenshotPoor.create(@screenshot_poor)

          movie_url=[]
          nokogiri_target(doc,movie_url,[],".highlight_movie",:"data-webm-hd-source")
          @movie={}
          @movie[:url]=movie_url
          @movie[:applist_id]=app.id
          Movie.create(@movie)

          # @tag=[]
          # nokogiri_text(doc,@tag,[],".app_tag")
          # @tag.delete("+")
          # Tag.create(@tag)

          @price={}
          nokogiri_target(doc,@price,:game_purchase_price,"#game_area_purchase .game_purchase_price",:"data-price-final")
          nokogiri_target(doc,@price,:game_purchase_price,"#game_area_purchase .game_purchase_discount",:"data-price-final")
          nokogiri_text(doc,@price,:discount_pct,"#game_area_purchase .discount_pct")
          nokogiri_text(doc,@price,:discount_original_price,"#game_area_purchase .discount_original_price")
          nokogiri_text(doc,@price,:discount_final_price,"#game_area_purchase .discount_final_price")
          @price[:applist_id]=app.id
          Price.create(@price)
        # end
      end
    end

    def nokogiri_src(doc,variable,key,selector)
      doc.css(selector).each do |value|
        if key.present?
          variable[key]=value.attribute("src").value
        else
          variable<<value.attribute("src").value
        end
      end
    end

    def nokogiri_target(doc,variable,key,selector,target)
      doc.css(selector).each do |value|
        if key.present?
          variable[key]=value[target]
        else
          variable<<value[target]
        end
      end
    end

    def nokogiri_text(doc,variable,key,selector)
      doc.css(selector).each do |value|
        if key.present?
          variable[key]=value.text.strip
        else
          variable<<value.text.strip
        end
      end
    end

    # def gender
    #   @gender
    # end

end
