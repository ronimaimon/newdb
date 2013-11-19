
$(document).ready(function(){
    
    $('.complete').autocomplete({
                   minLength: 2,     
                    //source: '/utils/getvalue.json'
					source: '/lab/utils/getvalue.json'    
    });
});
