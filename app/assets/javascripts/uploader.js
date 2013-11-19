
function validateForm()
{
	
	if (!validateField("ans_files"))
		{
		alert("Please select files to upload");
		return false;
		}
	
	if(validateField("r_e_name") || validateField("r_e_id")){
		return true;
	}
	var formElements = ["r[name]","r[owner]","r[loc]","r[comp]"];

	for (i = 0 ; i < formElements.length ; i++)
	{
		if(!validateField(formElements[i]))
			{
			alert("Make sure you filled all the research parameters");
			return false;
			}
	 }
	
	
}
	

function validateField(field_name)
{
  var x=document.forms["upload_form"][field_name].value;
  if (x==null || x=="")
  {
  return false;
  }
  return true;
}
