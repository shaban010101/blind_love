!function(){var r;jQuery(function(){return r.setupForm()}),r={setupForm:function(){return $("#new_order").submit(function(){return $("input[type=submit]").attr("disabled",!0),$("#card_number").length?(r.processCard(),!1):!0})},processCard:function(){var e;return e={number:$("#card_number").val(),cvc:$("#card_code").val(),expMonth:$("#card_month").val(),expYear:$("#card_year").val()},Stripe.createToken(e,r.handleStripeResponse)},handleStripeResponse:function(r,e){return 200===r?($("#subscription_stripe_card_token").val(e.id),$("#new_subscription")[0].submit()):($("#stripe_error").text(e.error.message),$("input[type=submit]").attr("disabled",!1))}}}.call(this);