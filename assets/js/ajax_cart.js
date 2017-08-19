function ajaxHandler(e) {
  e.preventDefault()
  var post_url = $(this).attr("action"); //get form action url
  var form_data = $(this).serialize(); //Encode form elements for submission

  $.post( post_url, form_data, function( response ) {
    $.bootstrapGrowl(response.message, {
      offset: {from: 'top', amount: 60},
      type: 'success'
    });
    $(".cart-count").text(response.cart_count)
  });
}

var ajaxCart = {
  init: function() {
    $(function(){
      $(".cart-form").on('submit', ajaxHandler)
    })
  }
}


export default ajaxCart
