ActiveAdmin.register ImageInfo do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
  # permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  action_item do
    link_to "로그인",new_admin_user_session_path
  end

menu priority: 2


  filter :similarity, as: :numeric_range_filter
  filter :status, as: :select,:collection => [["판정 전",0],["적합",1],["부적합",2],["다운완료",4]]
  filter :search_keyword,as: :select
  member_action :toggle, method: :post do
      @img_info = ImageInfo.find(params[:id])
      @past_status=@img_info.status
      if @img_info.status != 1
        @img_info.update(status:1)
      else
        @img_info.update(status:2)
      end
      respond_to do |format|
        format.js#s { render "toggle", :locals => {:id => params[:id]} }
      end

    end

  index do
    column :image_idx
    column :search_keyword

    column :img_thumb do |obj|
        image_tag obj.image_url ,class: "thumb",style: "height: 12em; max-width:30em; width:auto" if obj.image_url?
    end
    column :crawling_date
    column :similarity

    #1이 맞는거
    if !current_user.nil?
      column :status do |obj|
        label class:"switch" do
          render "toggle", id:obj.image_idx, status:obj.status
        end
      end
    end

    column :insta_data_id
    column :trip_idx
    actions if !current_user.nil?

  end


# image_idx: nil, image_url: nil, search_keyword: nil, crawling_date: nil,
# similarity: 0.0, status: 0, img_type: nil, insta_data_id: nil, trip_idx: nil, file_address: nil>
end
