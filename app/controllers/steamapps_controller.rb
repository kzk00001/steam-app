class SteamappsController < ApplicationController
  require "open-uri"
  require "nokogiri"
  
  def index
    #リストの取得
    uri = "http://api.steampowered.com/ISteamApps/GetAppList/v2"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    @doc=eval(html)
    @applist=@doc[:applist][:apps][4..104]#5個目からアプリ
    # データベースに保存
    # rails db:reset
    App.create(@applist)
    # 読み出してindex作成


  end
end
