// $(document).ready(function() {
//     $("#generate-tracking-btn").click(function() {
//         $.ajax({
//             url: "/orders/generate_tracking_number", // Acesta este URL-ul către acțiunea din controller care generează tracking number-ul
//             type: "GET",
//             success: function(response) {
//                 $("#order_tracking_number").val(response.tracking_number); // Actualizăm valoarea câmpului de text cu tracking number-ul generat
//             }
//         });
//     });
// });
$(document).ready(function() {
    $("#generate-tracking-btn").click(function(e) {
        e.preventDefault();

        var alphanumericCharacters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        var trackingNumber = '';

        for (var i = 0; i < 12; i++) {
            var randomIndex = Math.floor(Math.random() * alphanumericCharacters.length);
            trackingNumber += alphanumericCharacters.charAt(randomIndex);
        }

        $("#order_tracking_number").val(trackingNumber);
    });
});
