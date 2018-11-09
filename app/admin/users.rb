ActiveAdmin.register User do
  batch_action "download" do |ids|
    redirect_to "/admin/users.csv?q[id_in][]=" + ids.join("&q[id_in][]=")
  end

  batch_action "city state", form: {
    city: City.all.pluck(:city_name, :id).insert(0, ["Please select the city",0]),
    state: ["----"]
  }

  batch_action "city state2", form: {
    city: City.all.pluck(:city_name, :id).insert(0, ["Please select the city",0]),
    state: ["----"]
  }

  index do
    selectable_column
    id_column
    br
    a link_to ("10 명씩 보기"), "/admin/users?order=id_desc&per_page=10", class: "button-first per-button per-10-button status_tag"
    a link_to ("30 명씩 보기"), "/admin/users?order=id_desc&per_page=30", class: "per-button per-30-button status_tag"
    a link_to ("50 명씩 보기"), "/admin/users?order=id_desc&per_page=50", class: "per-button per-50-button status_tag"
    a link_to ("모두 보기"), "/admin/users?order=id_desc&per_page=#{User.all.size}", class: "per-button per-all-button status_tag"
    actions
  end

end
