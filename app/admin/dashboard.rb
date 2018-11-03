ActiveAdmin.register_page "Dashboard" do


  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  action_item do
    link_to "로그아웃",destroy_admin_user_session_path, method: :delete if !current_admin_user.nil?
  end
  action_item do
    link_to "로그인",new_admin_user_session_path,method: :get if current_admin_user.nil?
  end
  action_item :import_demo, only: :show do
    link_to 'Import Demo', '#'
  end
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
        panel "Recent data",style:"" do
          table border:"0",cellspacing:"0", cellpadding:"0", id:"index_table_image_infos" ,class:"index_table index" do
            render "thead"
            tbody do
              ImageInfo.order("image_idx desc").limit(4).map do |img_info|
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
                  if !current_admin_user.nil?
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
      end
      column do
        panel "Status Chart" do
          collec = ["판정 전","적합","부적합","","다운완료"]
          data = ImageInfo.group(:status).count.transform_keys{|key| collec[key]}
          bar_chart data, library:{pieSliceText: "value"}
        end
        panel "Data Count" do
          div "Total : #{ImageInfo.count } 개 "
          div "트립 : #{ImageInfo.where("trip_idx is not null").count } 개 "
          div "인스타 : #{ImageInfo.where("insta_data_id is not null").count } 개"
        end

      end
    end
    columns do
      panel "Log -   ( time:  #{ShowLog.last.time}  )",style:"background-color:#272935;color:#eff0ea" do
        div "#{ShowLog.last.log}".html_safe
      end
    end
  end # content

end
