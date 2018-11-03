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
batch_action :wonno do |ids|
  batch_action_collection.where(id: ids).find_each do |image_info|
    image_info.update(checked: 1)
  end
  redirect_to collection_path, alert: "이미지 인포를 성공적으로 변경했습니다."
end


action_item do
  link_to "로그아웃",destroy_admin_user_session_path, method: :delete if !current_admin_user.nil?
end
action_item do
  link_to "로그인",new_admin_user_session_path,method: :get if current_admin_user.nil?
end
menu priority: 2


  filter :similarity, as: :numeric_range_filter
  filter :status, as: :select,:collection => [["판정 전",0],["적합",1],["부적합",2],["다운완료",4]]
  filter :checked, as: :select,:collection => [["수기분류 전",0],["분류 후",1]]
  filter :search_keyword,as: :select
  member_action :toggle, method: :post do
      @img_info = ImageInfo.find(params[:id])
      @past_status=@img_info.status
      if @img_info.status != 1
        @img_info.update(status:1,checked:1)

      else
        @img_info.update(status:2,checked:1)
      end
      respond_to do |format|
        format.js#s { render "toggle", :locals => {:id => params[:id]} }
      end

    end

  index do
    selectable_column
    column :image_idx
    column :search_keyword

    column :img_thumb do |obj|
        image_tag obj.image_url ,class: "thumb",style: "height: 12em; max-width:30em; width:auto" if obj.image_url?
    end
    column :crawling_date
    column :similarity

    #1이 맞는거
    if !current_admin_user.nil?
      column :status do |obj|
        label class:"switch" do
          render "toggle", id:obj.image_idx, status:obj.status
        end
      end
    end
    column "insta/trip_id" do |obj|
      if obj.insta_data_id.nil?
        div "#{obj.trip_idx}"
      else
        div "#{obj.insta_data_id}"
      end
    end
    column "checked" do |obj|
      if obj.checked==0
        div "false"
      else
        div "true"
      end
    end

    actions if !current_admin_user.nil?

  end


# image_idx: nil, image_url: nil, search_keyword: nil, crawling_date: nil,
# similarity: 0.0, status: 0, img_type: nil, insta_data_id: nil, trip_idx: nil, file_address: nil>
end
