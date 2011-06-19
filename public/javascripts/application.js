$(document).ready(function(){
  $(".date_picker").datepicker({
    changeMonth : true,
    changeYear  : true,
    showOtherMonths : true
  });

  $('.vote_link').bind('ajax:success', function() {
    ;
  });
  setupSwapProfileImage();
  setupSelectAll();
});

function update_voting_links(old_profile) {
  var new_profile = $("#next_profile").val();
  $(".vote_link").each(function(){
    var a = $(this);
    var href = a.attr("href");
    var new_href = href.replace("/profile/" + old_profile,"/profile/" + new_profile);
    a.attr("href",new_href);
  });
}

function setup_next_input_container(upcoming_id) {
  $("#next_profile").val(upcoming_id);
}

function move_pictures(upcoming_src) {
  var next_src = $("#next_profile_image").attr("src");
  next_src = next_src.replace("/small","/watermarked");
  var current_src = $("#current_profile_image").attr("src");
  current_src = current_src.replace("/watermarked","/small");
  $("#last_profile_image").show().attr("src",current_src);
  $("#current_profile_image").attr("src",next_src);
  $("#next_profile_image").attr("src",upcoming_src);
}

function show_new_rating_for_last_member(rating) {
  $("#rating_display").html("Average Rating: "+ rating);
}

function disable_voting() {
  $("#voting_links").remove();
}

function setupSwapProfileImage(){
    $(".small-pictures img").live("click",function(){
        var obj = $(this),
            bigSrc = obj.attr("data-watermark");
        console.log("go!");
        $(".big-picture img").attr("src",bigSrc);
    });
}

function setupSelectAll(){
    var allSelector = '[name="all"]',
        childrenToSelect = ".select-all",
        checkedSelector = "checked";
    $(allSelector).change(function(){
        var isChecked = $(this).is(":"+checkedSelector);
        $(childrenToSelect).each(function(){
            $(this).attr(checkedSelector, isChecked);
        });
    });

    $(childrenToSelect).change(function(){
        var isChecked = true;
        $(childrenToSelect).each(function(){
            isChecked = $(this).attr(checkedSelector);
            return isChecked;
        });
        $(allSelector).attr(checkedSelector, isChecked);
    });
}