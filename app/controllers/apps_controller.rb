class AppsController < ApplicationController
  before_action :search_app

  def index
    # Apps.get_app
    if params[:q].nil?
      @applists=Applist.all.includes([:content, :screenshot_hd, :screenshot_poor, :movie, :tags, :price]).page(params[:page])
    else
      @applists=@q.result.distinct.includes([:tags, :price]).page(params[:page])
    end
  end

  def show
    @applist=Applist.find(params[:id])
  end

  def search
    @applists=@q.result.distinct.includes([:tags, :price]).page(params[:page])
  end

  private

  def search_app
    @q = Applist.ransack(params[:q])
    tag_record=Tag.order(record_num: 'ASC')
    @tag=[]
    i=0
    tag_record.each do |value|
      binding.pry
      @tag[:name]="#{value[:name]} (#{(value[:record_num])})"
      i+=1
    end
    # binding.pry
  end
end
