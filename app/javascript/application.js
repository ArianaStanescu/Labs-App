// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'jquery'

$(document).ready(function() {
    $("form").on("click", ".remove_fields", function(event) {
        $(this).prev("input[type=hidden]").val("1");
        $(this).closest("fieldset").hide();
        event.preventDefault();
    });

    $("form").on("click", ".add_fields", function(event) {
        var time = new Date().getTime();
        var regexp = new RegExp($(this).data("id"), "g");
        $(this).before($(this).data("fields").replace(regexp, time));
        event.preventDefault();
    });
});

//= require jquery
//= require jquery_ujs