	/*
** Created by davit on 2/25/16.
*/
$().ready(function(){
	$(".countryDialog").hide("fast")
	$(".companyDialog").hide("fast")
	var removeEndDateTxt = ' - Remove End Date'
	var addEndDateTxt = ' + Add End Date'
	if($("#endDate_day").val() == ''){
		$("#endDate").fadeOut("fast")
	} else {
		$(".addEndDate").text(removeEndDateTxt)
	}
	$(".addEndDate").click(function(){
		$("#endDate_day").val('').removeClass("invalid").addClass("valid");
		$("#endDate_month").val('').removeClass("invalid").addClass("valid");
		$("#endDate_year").val('').removeClass("invalid").addClass("valid");
		$("#endDate").slideToggle("fast")
		$(this).text(function(i, v){
			return v === addEndDateTxt ? removeEndDateTxt : addEndDateTxt
		})
	})
	$("#endDate_day").change(function() {
		$("checkBox").prop('checked', true)
	})
})
function createDialogCompany() {
	$( "#company-info").dialog({
		modal: true,
		width: '300',
		height:'150' ,
		buttons: [
			{
				text: "Confirm",
				click: function() { $(this).dialog("close"); }
			},
			{
				text: "Cancel",
				click: function() {
					$(this).dialog("close");
					$("#company").val('')
				}
			}
		]
	})
}
function createDialogCountry() {
    $( "#country-info").dialog({
        modal: true,
        width: '300',
        height:'150' ,
        buttons: [
            {
                text: "Confirm",
                click: function() { $(this).dialog("close"); }
            },
            {
                text: "Cancel",
                click: function() {
                    $(this).dialog("close");
                    $("#country").val('')
                }
            }
        ]
    })
}
