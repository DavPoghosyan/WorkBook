/**
 * Created by davit on 3/17/16.
 */
$().ready(function() {

    <!-- Real-time Validation -->
    <!-- WorkBook owner can't be less 2 chars -->
    $('#workbook').on('change', function() {
        requireValidate($(this));
    });

    <!-- Last Name can't be less 2 chars -->
    $('#company').on('change', function() {
        requireValidate($(this));
    });

    <!-- Email should match with email pattern -->
    $('#country').on('change', function() {
        requireValidate($(this));
    });

    <!-- StartDate should match with email pattern -->
    $('#startDate_year, #startDate_month, #startDate_day').change(function() {
        dateValidation($("#startDate"));
    });

    $('#endDate_year, #endDate_month, #endDate_day').change(function() {
        dateValidation($("#endDate"));
    });

    <!-- After Form Submitted Validation-->
    submitValidation();


});

function submitValidation() {

    $("#wp").submit(function(event){
        var form_data=$(this).serializeArray();
        var error_free=true;
        for (var input in form_data) {
            var element =$("#"+form_data[input]['name'].split(".")[0]);
            if(element.hasClass("required")) {
                requireValidate(element)
            }
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

function requireValidate(element) {
    if (element.val().length > 0) {
        element.removeClass("invalid").addClass("valid");
    } else {
        element.removeClass("valid").addClass("invalid");
    }
}

function dateValidation(dateElem) {
    var now = new Date();
    var day = $(dateElem.selector+"_day")
    var month = $(dateElem.selector+"_month")
    var year =  $(dateElem.selector+"_year")
    var fullDate = new Date(year.val(), month.val()-1, day.val())
    if (now < fullDate) {
        day.removeClass("valid").addClass("invalid");
        month.removeClass("valid").addClass("invalid");
        year.removeClass("valid").addClass("invalid");
        return;
    } else {
        day.removeClass("invalid").addClass("valid");
        month.removeClass("invalid").addClass("valid");
        year.removeClass("invalid").addClass("valid");
    }
}
