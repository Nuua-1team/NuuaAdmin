ActiveAdmin.register ImageInfo do
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

  controller do
    def toggle
      puts params
    end
  end

  index do
    column :image_idx
    column :search_keyword
    column :img_thumb do |obj|
        image_tag obj.image_url ,class: "thumb",style: "height: 12em; ,width:auto;" if obj.image_url?
    end

    column :crawling_date
    column :imilarity
    #
    column :status do |obj|
      if obj.status=="1"
        label class:"switch" do
          # a href:"asd" do
          input type:"checkbox",checked:""  do
            span class:"slider round" do
            # end
          end
        end
      end

      else

        label class:"switch" do
          # a href:"asd" do
          input type:"checkbox"  do
            span class:"slider round" do
            # end
          end
        end
      end
      end

      # div class:"toggle-bool-switches-container" do
      #   span do
      #     span id:"toggle-image_info-#{obj.image_idx}-status" , class:"toggle-bool-switch #{toggle}",
      #     input_html: {
      #       "data-object_id":obj.image_idx,
      #       "data-field":"status",
      #       "data-value":"0",
      #       "data-url":"/admin/image_infos/"+obj.image_idx.to_s
      #     }
      #   end
      # end
    end


    column :insta_data_id
    column :trip_idx
    actions

  end


# image_idx: nil, image_url: nil, search_keyword: nil, crawling_date: nil,
# similarity: 0.0, status: 0, img_type: nil, insta_data_id: nil, trip_idx: nil, file_address: nil>
end
