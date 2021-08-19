class AppsController < ApplicationController
  before_action :search_app

  require "open-uri"
  require "nokogiri"
  
  def index
    get_app
    @applists=Applist.all.includes([:content, :screenshot_hd, :screenshot_poor, :movie, :tags, :price]).page(params[:page])
    @applists=@p.result.includes([:tags, :price]).page(params[:page])
  end

  def show
    @applist=Applist.find(params[:id])
    get_news
  end

  def search
    @applists=@p.result.includes([:tags, :price]).page(params[:page])  # 検索条件にマッチした商品の情報を取得
  end

  private

  def search_app
    @p = Applist.ransack(params[:q])  # 検索オブジェクトを生成
    @tag=Tag.order(name: 'ASC')
  end

  def get_news
    uri = "http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=#{@applist[:appid]}&count=#{5}&maxlength=300&format=json"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    doc=eval(html)
    appnews=doc[:appnews][:newsitems]
    appnews.each do |value|
      value=value.slice(:gid,:title,:url,:author,:contents,:date)
      value[:applist_id]=@applist.id
      unless News.where(value).exists?
        News.create(value)
      end
    end
  end

  def get_app
    uri = "http://api.steampowered.com/ISteamApps/GetAppList/v2"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    doc=eval(html)
    applists=doc[:applist][:apps][4..20]#5個目からアプリ
    applists.each do |applist|
      url = "https://store.steampowered.com/app/#{applist[:appid]}"
      doc = Nokogiri::HTML(open(url),nil,"utf-8")
      price={}
      nokogiri_target(doc,price,:game_purchase_price,".game_purchase_price",:"data-price-final")
      nokogiri_target(doc,price,:game_purchase_price,".game_purchase_discount",:"data-price-final")
      unless price[:game_purchase_price].nil?
        price[:game_purchase_price]=price[:game_purchase_price].to_i/100
        price[:game_purchase_price]="¥ "+price[:game_purchase_price].to_s
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
              else
                tag=Tag.create(tag)
              end
              ApplistTag.create(applist_id:applist.id,tag_id:tag.id)
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

  def nokogiri_src(doc,variable,key,selector)
    doc.css(selector).each do |value|
      variable[key]=value.attribute("src").value
    end
  end

  def nokogiri_text(doc,variable,key,selector)
    doc.css(selector).each do |value|
      variable[key]=value.text.strip
    end
  end

  def nokogiri_target(doc,variable,key,selector,target)
    doc.css(selector).each do |value|
      variable[key]=value[target]
    end
  end

end
