/**
 * Created by davit on 3/17/16.
 */
$(document).ready(function() {
	// Name can't be blank
	$('#firstName').on('input', function() {
		var input=$(this);
		if (input.val().substring(0,4)=='www.'){input.val('http://www.'+input.val().substring(4));}
		var re = /(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?/;
		var is_url=re.test(input.val());
		if(is_url){input.removeClass("invalid").addClass("valid");}
		else{input.removeClass("valid").addClass("invalid");}
	});
});
