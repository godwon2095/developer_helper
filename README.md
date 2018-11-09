# 인썸니아 개발 헬퍼

* <a href="#active_admin_user_list">액티브어드민 리스트 원하는 개수 정렬</a>
* <a href="#active_admin_select_download">액티브어드민 선택한 항목만 CSV 다운로드 하기</a>
* <a href="#js_city_state">액티브어드민 배치액션 폼에서 city-state js로 구현하기</a>
* <a href="#image_direct_upload">이미지 즉각 업로드</a>

<h2 id="active_admin_user_list">액티브어드민 리스트 원하는 개수 정렬</h2>

![image](https://user-images.githubusercontent.com/37841168/48248476-d2c28680-e43a-11e8-9300-462373a33582.png)

어드민 페이지에서 특정 모델 가령 유저리스트를 10명씩 보기 30명씩 보기 모두 보기 등등을 구현하는 방법입니다.

액티브 어드민에서는 주소로 이를 처리하는데요 해당 주소는
~~~
/admin/users?order=id_desc&per_page=10"
~~~
형태로 날아가게 됩니다. 그래서 실질적으로 url의 모델명과 숫자부분만 편집해서 링크를 만들어주면 간단하게 해결할 수 있습니다.

그래서 실제 프로젝트에 이용하실 때는 아래와같이 코드를 사용하시면 됩니다.
~~~c
index do
    selectable_column
    id_column
    br
    a link_to ("10 명씩 보기"), "/admin/users?order=id_desc&per_page=10"
    a link_to ("30 명씩 보기"), "/admin/users?order=id_desc&per_page=30"
    a link_to ("50 명씩 보기"), "/admin/users?order=id_desc&per_page=50"
    a link_to ("모두 보기"), "/admin/users?order=id_desc&per_page=#{User.all.size}"
    actions
  end
~~~
이렇게 해주시고 클래스를 넣어 스타일까지 입히면 완벽합니다.

active_admin.rb 에서도 이를 해결 할 수 있는데요
~~~c
config.default_per_page = 30
~~~
~~~c
config.per_page = 10
~~~
~~~c
config.per_page = [10, 50, 100]
~~~
위처럼 처리 할 수도 있고
~~~c
controller do
  before_action only: :index do
    @per_page = 100
  end
end
~~~
이런식으로 컨트롤러에서도 처리해줄 수 있습니다.

하지만 기존 액티브어드민에서 제공하는 것보다 직접만드는게 더 보기 좋기 때문에 직접 만드시는 것을 추천합니다.

---

<h2 id="active_admin_select_download">액티브어드민 선택한 항목만 CSV 다운로드 하기</h2>

![image](https://user-images.githubusercontent.com/37841168/48249339-18cd1980-e43e-11e8-9a3c-f7c38e5f407b.png)

액티브 어드민에서 특정 모델의 특정 리스트 만을 액셀 형태로 다운받고싶다면 간단하게 구현 할 수 있습니다.

액티브 어드민에서는 이를 주소로 처리하는데요 

~~~c
  batch_action "download" do |ids|
    redirect_to "/admin/users.csv?q[id_in][]=" + ids.join("&q[id_in][]=")
  end
~~~
이렇게 배치액션하나만 만들어 주면 됩니다. /admin/모델명s.... 이런식으로 만들어주시면 됩니다.

---

<h2 id="js_city_state">액티브어드민 배치액션 폼에서 city-state js로 구현하기</h2>

액티브 어드민의 배치액션의 폼같이 직접 내부 요소들은 컨트롤하기 어려운 경우 이를 전부 js로 구현해야 합니다.

먼저 사용 할 리스트들은 직접 js 배열에 담아줍니다.
~~~c
var city1 = [
    {display: "state1", value: "0" },
    {display: "state2", value: "1" },
    {display: "state3", value: "2" }];

var city2 = [
    {display: "state4", value: "3" },
    {display: "state5", value: "4" },
    {display: "state6", value: "5" }];

var city3 = [
    {display: "state7", value: "6" },
    {display: "state8", value: "7" },
    {display: "state9", value: "8" }];
~~~

그다음은 위에서 만들어둔 특정 city의 배열이 들어왔을 때 그에 속한 state들을 지우고 다시 append 해주는 함수를 만들어 줍니다
~~~c
function call_state_by_city(city_ary){
  $('[name="state"]').empty();
  $('[name="state"]').append("<option>--Select--</option>");
  $(arr).each(function(i){
    $('[name="state"]').append("<option value=\""+city_ary[i].value+"\">"+city_ary[i].display+"</option>")
  });
}
~~~

이제는

---

<h2 id="image_direct_upload">이미지 즉각 업로드</h2>

이미지를업로드 할 때 사진을 올렸으면, 즉각적으로 이미지가 바뀌게 하는 js 코드입니다.

먼저 파일을 읽는 함수를 만들어 줍시다. 이름은 readURL 로 하겠습니다.
~~~c
  function readURL(input) {
         if (input.files && input.files[0]) {
             var reader = new FileReader();

             reader.onload = function (e) {
                 $('img').attr('src', e.target.result);
             };

             reader.readAsDataURL(input.files[0]);
         }
     }
~~~
파일이 한 개 또는 여러개 들어왔을 때 첫번 째 이미지를 js에서 제공하는 FileReader함수로 읽게 해주고 그 결과를 바로 이미지에 띄워주는 역할의 함수입니다.

~~~c
  $('input').on('change', function(){
    readURL(this);
  });
~~~
이후 change 함수로 this를 인수로 넘겨줍니다. 그럼 파일을 업로드 할 때마다 즉각적으로 이미지가 바뀌게 됩니다.
