//= require active_admin/base

var California = [
    {display: "Lon Angeles", value: "0" },
    {display: "San Diego", value: "1" }];

var Texas = [
    {display: "Dallas", value: "2" },
    {display: "Austin", value: "3" }];

var Assam = [
    {display: "Dispur", value: "4" },
    {display: "Guwahati", value: "5" }];

function call_state_by_city(city_ary){
  $('[name="state"]').empty();
  $('[name="state"]').append("<option>--Select--</option>");
  $(city_ary).each(function(i){
    $('[name="state"]').append("<option value=\""+city_ary[i].value+"\">"+city_ary[i].display+"</option>")
  });
}

function city_state(city_id){
  $.get("/get_states_by_city/" + city_id, function(data){
    var state = $('[name="state"]');
    state.empty();
    for (var i = 0; i < data.states.length; i++) {
      state.append('<option value=' + data.states[i].id + '>' + data.states[i].state_name + '</option>');
    }
  }, "json");
}

$(document).ready(function () {
// 액티브어드민의 모든요소가 로드 된 후 js를 실행하기 위해 document ready함수 안에 넣어줍니다.

  $('.batch_action[data-action=city_state]').on("click", function(){
  // 배치액션을 눌러야 내부 요소들을 그릴 수 있기 때문에 배치액션을 누르는 함수로 감싸줍니다.

    $('[name="city"]').on("change", function(){
      var select = $('[name="city"] option:selected').val();
      console.log(select);
      switch(select){
        case "1":
          call_state_by_city(California);
        break;

        case "2":
          call_state_by_city(Texas);
        break;

        case "3":
          call_state_by_city(Assam);
        break;

        default:
        //기본 셋팅도 해줍니다.
          $('[name="city"]').empty();
          $('[name="city"]').append("<option>--Select--</option>");
        break;
      }
    });
  });
});

$(document).ready(function(){
  $('.dropdown_menu_button').on("click", function(){
    $('.batch_action[data-action=city_state2]').on("click", function(){
      $('[name="city"]').change(function () {
        var val = $(this).val();
        console.log(val);
        city_state(val);
      });
    });
  });
})
