/**
 * Created by davit on 3/17/16.
 */
$().ready(function() {

    <!-- Real-time Validation -->
    <!-- First Name can't be less 2 chars -->
    $('#firstName').on('input', function() {
        var input = $(this);
        var firstNameLength = input.val().length;
        if (firstNameLength > 2) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- Last Name can't be less 2 chars -->
    $('#lastName').on('input', function() {
        var input = $(this);
        var firstNameLength = input.val().length;
        if(firstNameLength > 2) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- Email should match with email pattern -->
    $('#email').on('input', function() {
        var input=$(this);
        var emailPattern = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        var isEmail = emailPattern.test(input.val());
        if(isEmail) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- Passport Number should match with passport Number Pattern -->
    $('#passportNumber').on('input', function() {
        var input=$(this);
        var passportNumberPattern = /^[A-Z]{2}[0-9]{7}/;
        var isPassportNumber = passportNumberPattern.test(input.val());
        if(isPassportNumber) {
            input.removeClass("invalid").addClass("valid");
        } else {
            input.removeClass("valid").addClass("invalid");
        }
    });

    <!-- After Form Submitted Validation-->
    submitValidation();
});

function submitValidation() {

    $("#wb").submit(function(event){
        var form_data=$("#wb").serializeArray();
        var error_free=true;
        for (var input in form_data) {
            var element =$("#"+form_data[input]['name']);
            var invalid = element.hasClass("invalid");
            var error_element = $(element.selector+"-vem")
            if (invalid) {
                error_element.removeClass("jq-error").addClass("error_show");
                error_free = false;
            } else {
                error_element.removeClass("error_show").addClass("jq-error");
            }
        }
        if (!error_free){
            event.preventDefault()
            return false
        } else {
            return true
        }
    });
}
