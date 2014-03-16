$(document).ready(function() {
  $('#category-filter-form').submit(function() {
    var url = $(this).attr("action");
  	$.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      contentType: 'application/json',
      data: $('.category-filter-form').serializeArray()
      }).success(function(data) {
       // $(".small-block-grid-3").append(data);
       $(data).append(".small-block-grid-3");
       // alert("yo");
    });
  });

  $('#ordering').change(function() {
    $('#category-filter-form').submit();
  });
});