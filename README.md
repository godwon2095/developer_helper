# 인썸니아 개발 헬퍼

* <a href="#image_direct_upload">이미지 즉각 업로드</a>

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
