/**
 * Created by davit on 3/18/16.
 */
$().ready(function () {

    $('#dateOfBirth_year, #dateOfBirth_month, #dateOfBirth_day').change(function() {
        ageCalculation();
    })

});

function ageCalculation() {
    var now = new Date();
    var birthDay = $('#dateOfBirth_day').val();
    var birthMonth = $('#dateOfBirth_month').val();
    var birthYear = $('#dateOfBirth_year').val();
    var dateOfBirth = new Date(birthYear, birthMonth, birthDay)
    var age = Math.floor((now - dateOfBirth) / (365.25 * 24 * 60 * 60 * 1000));
    var today = now.getDate()
    var tm = now.getMonth() + 1
    if (birthMonth == tm && birthDay <= today) {
        age += 1
    }
    $('#age').val(age);
}