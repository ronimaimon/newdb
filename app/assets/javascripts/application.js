// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .


$(document).ready(function () {
//  $("#token-input-tag").tokenInput("/utils/tags.json", {
	$("#token-input-tag").tokenInput("/lab/utils/tags.json", {
    //prePopulate:       $(this).data("pre"),
    preventDuplicates: true,
    noResultsText:     "No results, needs to be created.",
    animateDropdown:   false,
    crossDomain: false,
    theme: "facebook"//,
        //  allowCustomEntry: true

    
    //,
      //  allowFreeTagging: true

  });
  
  $(".token_input").each(function(){
//	  $(this).tokenInput("/utils/tags.json", {
	$(this).tokenInput("/lab/utils/tags.json", {
	    prePopulate:       $(this).data("pre"),
	    preventDuplicates: true,
	    noResultsText:     "No results, needs to be created.",
	    animateDropdown:   false,
	    crossDomain: false,

	    theme: "facebook",
	    tokenFormatter: function(item) { 
	    	if(item.is_new) 
	    		return "<li><p> <b style='color: green'>" + item.name +"</b></p></li>";
	    	else
	    		return "<li><p>" + item.name +"</p></li>";
	    			},
		resultsFormatter: function(item) { 
	    	if(item.is_new) 
	    		return "<li> create " + item.name +"</p></li>";
	    	else
	    		return "<li>" + item.name +"</li>";
	    			},

	  });
	});
});
 /* var el = $(this);
  el.tokenInput(el.data("url"), {
    crossDomain: false,
    theme: "facebook",
    //prePopulate: el.data("pre"),
    preventDuplicates: true
  });
});*/