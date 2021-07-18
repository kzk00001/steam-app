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
    @doc=eval(html)
    @applist=@doc[:applist][:apps][4..8]#5個目からアプリ
    App.create(@applist)#rails db:reset

    # リストを読み出してスクレイピング
    @applist=App.order("created_at ASC")
    @applist.each do |app|
      @app=app[:appid]
      uri = "https://store.steampowered.com/app/#{@app}"
      @doc = Nokogiri::HTML(open(uri),nil,"utf-8")
      #アプリごと
      @uri=[]
      @doc.css(".highlight_screenshot_link").each do |link|
        # link.textは、link要素（この場合はaタグ)の中の文字列を取得します。
        @uri<<link["href"]
      end
    end


  end
end
