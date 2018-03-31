$(document).ready(function(){
  $('.disable-on-click').on('click', function(){
    $(this).attr('disabled', 'disabled');
    $(this).parent().submit();
  })
});
