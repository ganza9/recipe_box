$(document).ready(function(){
  $('#add_ingredient').click(function(e){
    e.preventDefault();
    input = $(this).prev();
    value = input.val();
    input[0].value = "";
    $('.ingredient-group').prepend('<div class="input-group">'+
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
    $('.tag-group').prepend('<div class="input-group">'+
                                  '<span class="input-group-addon"> Tag: </span>'+
                                  '<input id="tag" type="text" class="form-control input" name="tag[]" placeholder="Tag Me!" value="'+value+'">'+
                                  '</div>'+
                                  '<br>');
  })
})
