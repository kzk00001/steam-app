window.onload = function () {
  //写真の高さ取得
  var photoH = $("#photo>img").innerHeight();
  $("#photo").css("height", photoH + "px");
};

window.onload = function () {
  var click_flg = false;
  $("#navi a").click(function() {
      if (click_flg == false) {
          click_flg = true;
          $("#photo img").before("<img class='demo' src='" + $(this).attr("href") + "' alt=''>");
          $("#photo img:last").stop(true, false).fadeOut("fast", function() {
              $(this).remove();
              click_flg = false;
          });
          return false;
      } else {
          return false;
      }
  });
};