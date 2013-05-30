
$(document).ready(function(){
    // Below is the name of the textfield that will be autocomplete
    $('.complete').autocomplete({
        // This shows the min length of charcters that must be 
        // typed before the autocomplete looks for a match.
                    minLength: 2,
        // This is the source of the auocomplete suggestions. In this case a 
        // list of emails from the users controller, in JSON format.
                    source: '/measures/getvalue.json'
    })
});
