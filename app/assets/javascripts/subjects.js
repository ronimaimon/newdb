$(document).ready(function(){
	$("#all_age_g").change(function(){
		var selectedValue = $(this).find(":selected").val();
 		$(".age_g").val(selectedValue);
	});
	$("#all_age").change(function(){
		var selectedValue = $(this).val();
 		$(".age").val(selectedValue);
	});
	$("#all_control").change(function(){
		var selectedValue = $(this).is(':checked');
 		$(".control").prop('checked', selectedValue);
	});
	$("#all_hand").change(function(){
		var selectedValue = $(this).find(":selected").val();
 		$(".hand").val(selectedValue);
	});
	$("#all_tag").change(function(){
		var selectedValue = $("#all_tag").data()["tokenInputObject"].getTokens();
 			$.each(selectedValue, function (j,value) {
 				$(".tag").each( function () {
 					//$(this).data()["tokenInputObject"].clear();
 					$(this).data()["tokenInputObject"].add(value);});
 			});
 	});

});