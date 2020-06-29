
const GET_REPORTS_URL = 'localhost:3000/reports';

$(document).ready(function() {
  submit();
  // generateReport();

  function submit() {
    $('#btn-submit').click(function() {
      $('.loader').addClass('visible');
    });
  }

  // function generateReport() {
  //   $('.btn-generate-report').click(function(){
  //     $.ajax({
  //       type: 'GET',
  //       url: GET_REPORTS_URL,
  //       contentType: "application/json",
  //       dataType: 'json',
  //       success: function(result) {
  //         console.log(result);
  //       }
  //     });
  //   });
  // }
});