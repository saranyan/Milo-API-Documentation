
class HomeController < ApplicationController
  def index
  end
  
  def milo_submit
    url = "https://api.x.com/milo/v3/store_addresses?key=#{params[:api_key]}&zip_code=#{params[:zip_code]}"
    if params[:radius].nil? || params[:radius].blank?
      url += "&radius=10"
    else
      url += "&radius=#{params[:radius]}"
    end
    
    if !params[:merchant_ids].nil? && !params[:merchant_ids].blank?
      url += "&merchant_ids=#{params[:merchant_ids]}"
    end
    p url
    #store addresses API
    response_raw = (HTTParty.get url)["store_addresses"]
    #response_raw = response_raw[0..9] unless response_raw.size < 10
    @response = response_raw
    @url = url
  end
  
  def milo_product
  end
  
  def milo_review
    
  end
  
  def milo_inventory
    
  end
  
  def milo_inventory_submit
    if params[:product_id].nil? || params[:product_id].blank?
      if !params[:product_name].nil? && !params[:product_name].blank?
         product_response = JSON.parse(HTTParty.get("https://api.x.com/milo/v3/products?key=#{params[:api_key]}&q=#{params[:product_name]}&per_page=10"))
         product_id = (product_response["products"].first)["product_id"]
         base_url = "https://api.x.com/milo/v3/availability?key=#{params[:api_key]}&product_id=#{product_id}&zip_code=#{params[:zip_code]}"  
      end
    else
      base_url = "https://api.x.com/milo/v3/availability?key=#{params[:api_key]}&product_id=#{params[:product_id]}&zip_code=#{params[:zip_code]}"
    end
    p base_url
    
    response_raw = HTTParty.get base_url
    
    @response = response_raw
    @url = base_url
  end
  
  def milo_review_submit
    if params[:product_id].nil? || params[:product_id].blank?
      if !params[:product_name].nil? && !params[:product_name].blank?
         product_response = JSON.parse(HTTParty.get("https://api.x.com/milo/v3/products?key=#{params[:api_key]}&q=#{params[:product_name]}&per_page=10"))
         product_id = (product_response["products"].first)["product_id"]
         base_url = "https://api.x.com/milo/v3/reviews?key=#{params[:api_key]}&product_id=#{product_id}&page=0&per_page=1"  
      end
    else
      base_url = "https://api.x.com/milo/v3/reviews?key=#{params[:api_key]}&product_id=#{params[:product_id]}&page=0&per_page=1"
    end
    p base_url
    response_raw = HTTParty.get base_url
    p response_raw
    @response = response_raw
    @url = base_url
  end
  
  def milo_product_submit
    base_url = "https://api.x.com/milo/v3/products?key=#{params[:api_key]}&q=#{params[:query]}&per_page=10"
    if !params[:zip_code].nil? && !params[:zip_code].blank?
      base_url += "&zip_code=#{params[:zip_code]}"
    end
    if !params[:min_price].nil? && !params[:min_price].blank?
      base_url += "&min_price=#{params[:min_price]}"
    end
    if !params[:max_price].nil? && !params[:max_price].blank?
      base_url += "&max_price=#{params[:max_price]}"
    end
    if !params[:min_rating].nil? && !params[:min_rating].blank?
      base_url += "&min_rating=#{params[:min_rating]}"
    end
    if !params[:max_rating].nil? && !params[:max_rating].blank?
      base_url += "&max_rating=#{params[:max_rating]}"
    end
     if !params[:category_ids].nil? && !params[:category_ids].blank?
        base_url += "&category_ids=#{params[:category_ids]}"
      end
      if !params[:merchant_ids].nil? && !params[:merchant_ids].blank?
        base_url += "&merchant_ids=#{params[:merchant_ids]}"
      end
      if !params[:is_deal].nil? && !params[:is_deal].blank?
        base_url += "&is_deal=#{params[:is_deal]}"
      end
      if !params[:on_sale].nil? && !params[:on_sale].blank?
        base_url += "&on_sale=#{params[:on_sale]}"
      end
     #store addresses API
      p base_url
      response_raw = JSON.parse(HTTParty.get base_url)
      p response_raw
      #p nil.value
      #response_raw = response_raw[0..9] unless response_raw.size < 10
      @response = response_raw
      @merchants = response_raw["merchants"]
      @url = base_url
      
  end

end
