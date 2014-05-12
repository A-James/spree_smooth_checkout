//= require_tree .

$( function() {

  $('#lock-summary')

    .width($('#checkout-summary').width() - 10) //remove 10px for bootstrap negative margins

  $('#add-discount-code').on('click', function(){
    $('#discount-code').removeClass('hidden');
  });

  // $("#checkout_form_address")
  // .on("ajax:beforeSend", function(e, xhr, status, error){
  //    $("#new_post").append("<p>LOADING</p>");
  //   })
  //   .on("ajax:success", function(e, data, status, xhr){
  //    console.log(data);
  //    var summary = 
  //      "<strong>" + $('#order_firstname').val() + " " + 
  //      $("#order_lastname").val() + "</strong><br/>" + 
  //      $("#order_bill_address_attributes_address1").val() + ", " + 
  //      $("#order_bill_address_attributes_city").val() + "<br/>";
  //    $('.checkout-step').toggleClass('checkout-step-off').toggleClass('checkout-step-on');
  //    $('.info span').html(summary);
  //   })
  //   .on("ajax:error", function(e, xhr, status, error){
  //    $("#new_post").append("<p>ERROR</p>");
  //   });

});

$.validator.setDefaults({
    highlight: function(element) {
      $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    },
    unhighlight: function(element) {
      $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
    },
    errorElement: 'span',
    errorClass: 'help-block',
    errorPlacement: function(error, element) {}
});

//------ below line moved in from page, doesn't work here yet

//Only search when value is changed from previous
//Disable once change clicked
//Only display a 2 part result
//Don't use on second form
//Set drop down selectors to correct values
//Set all validation / events to trigger on auto fill

// geocoder = new google.maps.Geocoder();

// findAddress = function(postcode) {

//   geocoder.geocode( { 'address': postcode + ", UK" }, function(results, status) {

//     // console.log(results);

//     if (results[0]){

//       try {
//         var postalTown = $.grep(results[0].address_components, function(el){
//           return $.inArray('postal_town', el.types) !== -1;
//         })[0].long_name;
//       } catch(e) { false }
//       try {
//         var locality = $.grep(results[0].address_components, function(el){
//           return $.inArray('locality', el.types) !== -1;
//         })[0].long_name;
//       } catch(e) { false }
//       try {
//         var adminArea = $.grep(results[0].address_components, function(el){
//           return $.inArray('administrative_area_level_1', el.types) !== -1;
//         })[0].long_name;
//       } catch(e) { false }
//       try {
//         var country = $.grep(results[0].address_components, function(el){
//           return $.inArray('country', el.types) !== -1;
//         })[0].long_name;
//         var countryCode = $.grep(results[0].address_components, function(el){
//           return $.inArray('country', el.types) !== -1;
//         })[0].short_name;
//       } catch(e) { false }

//       finalCity = postalTown ? postalTown : locality;
//       friendlyCity = finalCity ? finalCity + ", " : "";
//       friendlyAdminArea = adminArea ? adminArea + ", " : "";
//       friendlyCountry = country ? country : "";;

//       $('#address-computed').text(friendlyCity + friendlyAdminArea + friendlyCountry);
//       $('#change-address').removeClass('hidden');
//       $("#order_bill_address_attributes_country_id option[data-iso=" + countryCode +"]").attr("selected","selected") ;

//       $('#order_bill_address_attributes_city').val(finalCity);

//     }
    
//   });

// }

// $('#change-address').on('click', function(){
//   $('.change-address').addClass('hidden');
//   $('.address-hidden').removeClass('hidden');
//   return false;
// });

// $('#order_bill_address_attributes_zipcode').on('keyup', function(){ //keyup change paste (omit tab-on keyup), autofill
//   var currentVal = $(this).val();
//   if (currentVal.length >= 4) {
//     findAddress(currentVal);
//   } else {
//     $('#address-computed').text('');
//     $('#order_bill_address_attributes_city').val('');
//     $('#change-address').addClass('hidden');
//   }
// });