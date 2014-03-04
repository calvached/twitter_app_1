$(document).ready(function() {
  var url = window.location.href;
  var userName = (/\w\/(\w+)/).exec(url);
  if (userName !== null){
    $('.container').html("<h1> Wakwakwak... </h1><div id='spinner'></div>")
    $.get('/' + userName[1], function(serverResponse) {
      $('.container').html(serverResponse);
    });
  };
});
