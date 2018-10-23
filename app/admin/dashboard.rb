ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent data" do
          table border:"0",cellspacing:"0", cellpadding:"0", id:"index_table_image_infos" ,class:"index_table index" do
            render "thead"
            tbody do
              ImageInfo.order("image_idx desc").limit(7).map do |img_info|
                tr class:"odd",id:"image_info_#{img_info.image_idx}" do
                  td class:"col col-image_idx" do
                    img_info.image_idx
                  end
                  td class:"col col-search_keyword" do
                    img_info.search_keyword
                  end
                  td class:"col col-img_thumb" do
                    img src:"#{img_info.image_url}",style:"height: 6em;max-witdh:10em;"
                  end
                  td class:"col col-similarity" do
                    img_info.similarity
                  end
                  td class:"col col-status" do
                    label class:"switch" do
                      render "toggle", id:img_info.image_idx, status:img_info.status
                    end
                  end
                end
              end
            end
          end
        end
      end
      column do
        panel "Status Chart" do
          collec = ["판정 전","적합","부적합","","다운완료"]
          data = ImageInfo.group(:status).count.transform_keys{|key| collec[key]}
          bar_chart data, library:{pieSliceText: "value"}
        end
        panel "Keyword Rating" do
          pie_chart ImageInfo.group(:search_keyword).count
        end
      end
    end
  end # content
end
