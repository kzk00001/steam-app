$(function(){
  $('#subImg img').on('click',function(){
      //mainに切り替えるimgのsrc取得
      img = $(this).attr('src');
      //currentクラス付け替え
      $('#subImg li').removeClass('current');
      $(this).parent().addClass('current');
      //fadeOutできたらsrc変更してfadeIn
      $('#mainImg img').fadeOut(50, function() {
          $('#mainImg img').attr('src', img).on('load', function() {
               $(this).fadeIn();
          })
     })
  });
});