$(document).ready(function() {
  $('#tweet_form').on('submit', function(event){
    event.preventDefault();
    var url = $(this).attr('action');
    var data = {tweet: $(this.tweet).val()};

    if($(this.tweet).val() !== '') {
      $('input').attr('disabled', 'disabled');
    };

    $.post(url, data, function(response){
        $('#ajax-message').append('<p>Successful!</p>');
        $("input").removeAttr("disabled");
        $('#tweet_form input[name=tweet]').val('');
    });
  });
});
