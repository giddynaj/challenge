class WelcomeController < ApplicationController 

def index 
if request.format == :json
  case params['type']
  when 'brands'
    render :text => "{\"brands\":#{Brand.get_all_with_counts.to_json}, \"counts\":\"#{Brand.get_count}\"}"
  when 'brand'
    brands = Brand.all
    render :text => "[{\"brand\":\"#{brands.to_json}\"}]"
  end
else

end
end
end
