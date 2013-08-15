$(document).ready(function(){
	$("#all_age").change(function(){
		var selectedValue = $(this).find(":selected").val();
 		$(".age").val(selectedValue)
	})
	$("#all_year").change(function(){
		var selectedValue = $(this).find(":selected").val();
 		$(".year").val(selectedValue)
	})
	$("#all_control").change(function(){
		var selectedValue = $(this).is(':checked');
 		$(".control").prop('checked', selectedValue)
	})
});