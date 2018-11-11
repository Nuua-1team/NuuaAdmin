ActiveAdmin.register ImageInfo do

# config.current_filters = false

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
batch_action :checked do |ids|
  batch_action_collection.where(image_idx: ids).find_each do |image_info|
    image_info.update(checked: 1)
  end
  redirect_to collection_path(request.query_parameters)

end

# inheritable_setting :current_filters, false

#
# controller do
#   def index
#     index! do |format|
#
#       @image_infos = ImageInfo.all.order("image_idx desc").where("not status = 0").page(params[:page]).per(100)
#       # end
#       if params[:q]
#         @image_infos = @image_infos.ransack(params[:q]).result
#       else
#         @image_infos = @image_infos.where("checked = false")
#       end
#
#       format.html
#       format.csv   { stream_csv }
#       format.json  { render json: @users }
#       format.xml   { render xml: @users }
#     end
#   end
# end

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

    selectable_column if !current_admin_user.nil?
    column :image_idx

    column :img_thumb do |obj|
        image_tag obj.image_url ,class: "thumb",style: "height: 12em; max-width:30em; width:auto" if obj.image_url?
    end
    if !current_admin_user.nil?
      column :status do |obj|
        label class:"switch" do
          render "toggle", id:obj.image_idx, status:obj.status
        end
      end
    end
    column :similarity
    column "checked" do |obj|
      if obj.checked==0
        div "false"
      else
        div "true"
      end
    end
    column :crawling_date

    column :search_keyword
    #1이 맞는거

    column "insta/trip_id" do |obj|
      if obj.insta_data_id.nil?
        div "#{obj.trip_idx}"
      else
        div "#{obj.insta_data_id}"
      end
    end


    actions if !current_admin_user.nil?
  end


# image_idx: nil, image_url: nil, search_keyword: nil, crawling_date: nil,
# similarity: 0.0, status: 0, img_type: nil, insta_data_id: nil, trip_idx: nil, file_address: nil>
end
