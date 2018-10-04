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
          table input_html:{border:"0",cellspacing:"0", cellpadding:"0", id:"index_table_image_infos" ,class:"index_table index"} do
            render "thead"
            tbody do
              ImageInfo.order("image_idx desc").limit(5).map do |img_info|
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
                end
              end

            end
          end
        end
      end
      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end

#
#
# <table border="0" cellspacing="0" cellpadding="0" id="index_table_image_infos" class="index_table index">
#
#                         <tbody>
#                           <tr class="odd" id="image_info_11418">
#                             <td class="col col-image_idx">11418</td>
#                             <td class="col col-search_keyword">경복궁</td>
#                             <td class="col col-img_thumb"><img class="thumb" style="height: 12em; max-width:30em; width:auto" src="https://media-cdn.tripadvisor.com/media/video-t/01/a8/e4/d4/gyeongbokgung-palace-2.jpg"></td>
#                             <td class="col col-crawling_date">2018년 10월 02일, 18시 18분 20초 UTC</td>
#                             <td class="col col-similarity">0.0</td>
#                             <td class="col col-status">
#                               <label class="switch">
#                                 <a data-remote="true" rel="nofollow" data-method="post" href="/admin/image_infos/11418/toggle">
#                                 <input type="checkbox">
#                                 <span class="slider round"></span>
#                               </a></label>
#                             </td>
#                             </tr>
#                         </tbody>
#                       </table>
