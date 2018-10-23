ActiveAdmin.register TripMetadata do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
action_item do
  link_to "로그아웃",destroy_admin_user_session_path, method: :delete if !current_admin_user.nil?
end
action_item do
  link_to "로그인",new_admin_user_session_path,method: :get if current_admin_user.nil?
end

index do
  column :trip_idx
  column :trip_review_url
  column :trip_gallery_id

  actions if !current_admin_user.nil?

end
menu priority: 3
end
