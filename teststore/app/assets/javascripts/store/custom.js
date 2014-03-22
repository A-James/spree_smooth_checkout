$( function() {

  $('#lock-summary')

    .width($('#checkout-summary').width() - 10) //remove 10px for bootstrap negative margins

    .affix({
      offset: {
      top: 90 } //height of header
    });

  $('#add-discount-code').on('click', function(){
    $('#discount-code').removeClass('hidden');
  });

});