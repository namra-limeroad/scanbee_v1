/**
 * Created by namra on 11/03/16.
 */

var Scanbee = Scanbee || {};
Scanbee.JS_Functions = function () {


    var products_listing = function () {

        $.ajax({
            url:"/sb_api/order_details",
            type: 'GET',
            datatype: 'json',
            success: function(data) {
                var prod_json = data['prod_details'];
                var cart_json =  data['cart_details']
                var prod_quant = data['prod_quant'];
                var json_len = prod_json.length;
                var color_array = ["red","amber","green","cyan","purple","orange"]
                for (var i = 0; i < json_len; i++) {

                    prod_init = prod_json[i].title.charAt(0);
                    prod_title = prod_json[i].title;
                    prod_price =  prod_json[i].cp;
                    prod_content = prod_json[i].content+" "+prod_json[i].content_unit;

                var prod_row =
                    "<li class='mdl-list__item mdl-list__item--two-line clip'>" +
                    "<span class='mdl-list__item-primary-content'> " +
                    "<i class='material-icons mdl-list__item-avatar mdl-color--"+color_array[i%6]+"-400'>"+prod_init+"</i> " +
                    "<strong class='p-color clip2'>"+prod_title+"</strong><br/> " +
                    "<strong class='mdl-list__item-sub-title pink-color'>"+prod_quant[i]+" &#215; " +
                    "<i class='fa fa-inr'></i>" +
                    "<span style='font-size:16px;'>"+prod_price+"</span>, "+prod_content+"</strong></span>" +
                    "<strong class='mdl-list__item-secondary-content'>" +
                    "<span class='mdl-list__item-secondary-info p-color'>" +
                    "<i class='fa fa-inr'></i> " +
                    "<span class='ft-30'>"+prod_price*prod_quant[i]+"</span>" +
                    "</span>" +
                    "</strong>" +
                    "</li>";

                    $("#products-listing").append(prod_row);
                }
                var cart_details = "<table class='col-centered tax-table' cellpadding='10'><tr> " +
                    "<td><i class='fa fa-shopping-basket'></i>&nbsp;<strong class='marg-icon pink-color'>" +
                    "<i class='fa fa-inr'></i> "+cart_json.cart_value+" </strong></td>" +
                    "<td><i class='fa fa-plus-square'></i>&nbsp;<strong class='marg-icon pink-color'> " +
                    "<i class='fa fa-inr'></i>"+ cart_json.tax +"</strong></td> " +
                    "<td><i class='fa fa-minus-square'></i>&nbsp;<strong class='pink-color'> " +
                    "<i class='fa fa-inr'></i>"+ cart_json.discount +"</strong> </td></tr></table>";
                $('#cart_details').append(cart_details)
                var set_amount = cart_json.cart_value - cart_json.discount + cart_json.tax;
                var pay_amount = "<strong><i class='fa fa-inr'></i> <span class='ft-18'>"+set_amount+"</span></strong>"
                $('#pay_amount').append(pay_amount)
            },
            fail: function (e, data) {

            }
        });
    };

    this.init = function () {
        products_listing()
    };


};

if (window.scanbee == undefined) {
    window.scanbee = new Scanbee.JS_Functions();
}