$(document).ready(function(){
  $('.container-fluid').css('min-height' , $(window).height()- $('.jumbotron').innerHeight());
  $('#add_ingredient').click(function(e){
    e.preventDefault();
    input = $(this).prev();
    value = input.val();
    input[0].value = "";
    $('.ingredient-group').append('<div class="input-group">'+
                                  '<span class="input-group-addon"> Ingredient: </span>'+
                                  '<input id="ingredient" type="text" class="form-control" name="ingredient[]" placeholder="What will I have?" value="'+value+'">'+
                                  '</div>'+
                                  '<br>');
  })
  $('#add_tag').click(function(e){
    e.preventDefault();
    input = $(this).prev();
    value = input.val();
    input[0].value = "";
    $('.tag-group').append('<div class="input-group">'+
                                  '<span class="input-group-addon"> Tag: </span>'+
                                  '<input id="tag" type="text" class="form-control input" name="tag[]" placeholder="Tag Me!" value="'+value+'">'+
                                  '</div>'+
                                  '<br>');
  })
  $('.hide_block').click(function(e){
    e.preventDefault();
    input = $(this).prev();
    input[0].value = "delete";
    $(this.parentElement).hide();
  })

  $('#add_new_ingredient').click(function(e){
    e.preventDefault();
    input = $(this).prev();
    value = input.val();
    input[0].value = "";
    $('.ingredient-group').append('<div>'+
                                  '<input id="tag" type="text" class="form-control existing-input" name="ingredient[]" value="'+value+'">'+
                                  '<span class="btn btn-danger btn-sm existing-link hide_block">'+
                                    '<span class="glyphicon glyphicon-minus"></span>'+
                                  '</span>'+
                                  '</div>');
    $(".hide_block").bind("click", function(e){
      e.preventDefault();
      input = $(this).prev();
      input[0].value = "delete";
      $(this.parentElement).hide();
    });
  })

  $('#add_new_tag').click(function(e){
    e.preventDefault();
    input = $(this).prev();
    value = input.val();
    input[0].value = "";
    $('.tag-group').append('<div>'+
                            '<input id="tag" type="text" class="form-control existing-input" name="tag[]" placeholder="Tag Me!" value="'+value+'">'+
                            '<span class="btn btn-danger btn-sm existing-link hide_block">'+
                              '<span class="glyphicon glyphicon-minus"></span>'+
                            '</span>'+
                            '</div>');
    $(".hide_block").bind("click", function(e){
      e.preventDefault();
      input = $(this).prev();
      input[0].value = "delete";
      $(this.parentElement).hide();
    });

  })


})
