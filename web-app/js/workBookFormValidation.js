/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {
    $('#wb').validate({
        rules: {
            firstName:{
                minlength: 3
            },
            lastName:{
                minlength: 3
            },
            email: {
                email: true
            },
            passportNumber: {
                passportNumberRegExp: true
            },
        }
    });

    $.validator.addMethod("passportNumberRegExp", function (value, element) {
        return this.optional(element) || /^[A-Z]{2}[0-9]{7}/.test(value);
    }, 'Please enter a valid passport number');
});
