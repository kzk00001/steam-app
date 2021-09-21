class Apps
  # def self.get_app
  #   puts "hoge"
  # end

  #rails runner Apps.get_app

  def self.get_app
    puts "hoge"

    require "open-uri"
    require "nokogiri"
    uri = "http://api.steampowered.com/ISteamApps/GetAppList/v2"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    doc=eval(html)
    applists=doc[:applist][:apps][4..-1]#5個目からアプリの情報
    increment=10#1度にスクレイピングするアプリの数
    if WebScraping.order(updated_at: :desc).limit(1).blank?
      scraped_num=0
      index=[scraped_num+1..scraped_num+increment]
    else
      web_scraping=WebScraping.order(updated_at: :desc).limit(1)
      scraped_num=web_scraping[0][:scraped_num].to_i
      if scraped_num+increment>applists.length
        index=[scraped_num+1..applists.length]
        scraped_num=0
      else
        scraped_num+=increment
        index=[scraped_num+1..scraped_num+increment]
      end
    end
    web_scraping={}
    web_scraping[:applists_length]=applists.length
    web_scraping[:scraped_num]=scraped_num
    WebScraping.create(web_scraping)
    applists=applists[index[0]]
    applists.each do |applist|
      url = "https://store.steampowered.com/app/#{applist[:appid]}"
      doc = Nokogiri::HTML(open(url),nil,"utf-8")
      price={}
      nokogiri_target(doc,price,:game_purchase_price,".game_purchase_price",:"data-price-final")
      if price[:game_purchase_price].nil?
        nokogiri_target(doc,price,:game_purchase_price,".game_purchase_discount",:"data-price-final")
      end
      unless price[:game_purchase_price].nil?
        price[:game_purchase_price]=price[:game_purchase_price].to_i/100
        nokogiri_text(doc,price,:discount_pct,"#game_area_purchase .discount_pct")
        nokogiri_text(doc,price,:discount_original_price,"#game_area_purchase .discount_original_price")
        nokogiri_text(doc,price,:discount_final_price,"#game_area_purchase .discount_final_price")
        if Applist.where(appid: applist[:appid]).exists?
          applist=Applist.find_by(applist)
          price[:applist_id]=applist.id
          Price.create(price)
        else
          applist=Applist.create(applist)
          price[:applist_id]=applist.id
          Price.create(price)

          content={}
          nokogiri_text(doc,content,:glance_detail,".glance_details")
          nokogiri_src(doc,content,:header_image_url,".game_header_image_full")
          nokogiri_text(doc,content,:description,".game_description_snippet")
          nokogiri_text(doc,content,:review_summary,"#userReviews .game_review_summary")
          nokogiri_text(doc,content,:review_summary,"#userReviews .summary")
          nokogiri_text(doc,content,:release_date,".date")
          nokogiri_text(doc,content,:developer,"#developers_list")
          content[:applist_id]=applist.id
          Content.create(content)

          doc.css(".highlight_screenshot_link").each do |value|
            screenshot_hd={}
            screenshot_hd[:url]=value[:href]
            screenshot_hd[:applist_id]=applist.id
            ScreenshotHd.create(screenshot_hd)
          end

          doc.css(".highlight_strip_screenshot img").each do |value|
            screenshot_poor={}
            screenshot_poor[:url]=value.attribute("src").value
            screenshot_poor[:applist_id]=applist.id
            ScreenshotPoor.create(screenshot_poor)
          end

          doc.css(".highlight_movie").each do |value|
            movie={}
            movie[:url]=value[:"data-webm-hd-source"]
            movie[:applist_id]=applist.id
            Movie.create(movie)
          end

          doc.css(".app_tag").each do |value|
            unless value.text.strip.include?("+")
              tag={}
              tag[:name]=value.text.strip
              if Tag.where(tag).exists?
                tag=Tag.find_by(tag)
                tag[:record_num]=tag[:record_num].to_i+1
                tag[:name_record]="#{tag[:name]} (#{tag[:record_num]})"
                tag.update(record_num:tag[:record_num],name_record:tag[:name_record])
              else
                tag[:record_num]=1
                tag[:name_record]="#{tag[:name]} (#{tag[:record_num]})"
                tag=Tag.create(tag)
              end
              ApplistTag.create(applist_id:applist.id,tag_id:tag.id)
            end
          end

          uri = "http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=#{applist[:appid]}&count=#{5}&maxlength=300&format=json"
          charset = nil
          html = open(uri) do |h|
            charset = h.charset
            h.read
          end
          doc=eval(html)
          appnews=doc[:appnews][:newsitems]
          appnews.each do |value|
            value=value.slice(:title,:url,:author,:contents,:date)
            value[:applist_id]=applist.id
            unless News.where(value).exists?
              News.create(value)
            end
          end

        end
      else
        unless DiscardedApplist.where(appid: applist[:appid]).exists?
          nokogiri_text(doc,applist,:release_date,".date")
          nokogiri_text(doc,applist,:price,".game_purchase_price")
          nokogiri_text(doc,applist,:review_summary,"#userReviews .game_review_summary")
          nokogiri_text(doc,applist,:review_summary,"#userReviews .summary")
          DiscardedApplist.create(applist)
        end
      end

    end
  end

  def self.nokogiri_src(doc,variable,key,selector)
    doc.css(selector).each do |value|
      variable[key]=value.attribute("src").value
    end
  end

  def self.nokogiri_text(doc,variable,key,selector)
    doc.css(selector).each do |value|
      variable[key]=value.text.strip
    end
  end

  def self.nokogiri_target(doc,variable,key,selector,target)
    doc.css(selector).each do |value|
      variable[key]=value[target]
    end
  end
end