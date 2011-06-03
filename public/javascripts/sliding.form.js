$(function() {

	var fieldsetCount = $('form').children().length,
		current	= 1,
		stepsWidth = 0,
		widths = new Array();
		
	$('#steps .step').each(function(i){
        var $step = $(this);
		widths[i] = stepsWidth;
        stepsWidth += $step.width();
    });
	$('#steps').width(stepsWidth);
		
	// to avoid problems in IE, focus the first input of the form
	$('form').children(':first').find(':input:first').focus();
	$('#navigation').show();
	
	// slide to the corresponding fieldset
    $('#navigation a').bind('click',function(e){
		var $this = $(this),
			prev = current,
			isValid = true;
		$this.closest('ul').find('li').removeClass('selected');
        $this.parent().addClass('selected');
		current = $this.parent().index() + 1;
		
		// validate all if at the end
	    if(current == fieldsetCount) {
		    isValid = validateSteps();
        }
		else {
			isValid = validateStep(prev);
        }
        if(isValid){
			// set selected tab
			$this.closest('ul').find('li').removeClass('selected');
			$this.parent().addClass('selected');
			// focus on first input
		    $('form').children(':nth-child('+ parseInt(current) +')').find(':input:first').focus();
			// animate
            $('#steps').stop().animate({ marginLeft: '-' + widths[current-1] + 'px' },500);
        }
		else {
			current = prev
		}
        e.preventDefault();
    });
	
	// pressing tab on the last input will slide to the next fieldset
	$('form > fieldset').each(function(){
		var $fieldset = $(this);
		$fieldset.children(':last').find(':input').keydown(function(e){
			if (e.which == 9){
				$('#navigation li:nth-child(' + (parseInt(current)+1) + ') a').click();
				/* force the blur for validation */
				$(this).blur();
				e.preventDefault();
			}
		});
	});
	
	// validates errors on all the fieldsets
	function validateSteps(){
		var isValid = true;
		for(var i = 1; i < fieldsetCount; ++i){
			if(!validateStep(i)){
				isValid = false;
			}
		}
		$('form').data('errors',!isValid);
        return isValid;
	}
	
	// validates one fieldset
	function validateStep(step){
        var isValid = true,
			link = $('#navigation li:nth-child(' + parseInt(step-1) + ') a'),
			valclass = 'checked';
		step++;
		if(step == fieldsetCount){
			return true;
		}
		$('form').children(':nth-child('+ parseInt(step) +')').find(':input:not(button)').each(function(){
			if(!validateInput($(this))){
               isValid = false;
            }
		});
		link.parent().find('.error,.checked').remove();
		if(!isValid){
			valclass = 'error';
		}
		$('<span class="'+valclass+'"></span>').insertAfter(link);
		return isValid;
	}
	
	// validate object
	function validateInput(obj){
		var isValid = true,
			val = jQuery.trim($this.val());
		// required
		if($this.hasClass("required")){
			isValid = isValid && val != "";
		}
		// confirmed
		if($this.hasClass("confirmable")){
			isValid = isValid && confirmConfirmable($this);
		}
		showValidationErrorsIfNeeded($this,isValid);
		return isValid;
	}

    function checkRequiredCheckBoxes(){
        var total = $(".required-for-submit").length;
            totalChecked = $(".required-for-submit:checked").length;

        if(total == totalChecked){
            $("#register-button").removeClass("hidden");
            return true;
        }
        else {
            $("#register-button").addClass("hidden");
            return false;
        }
    }

    function mirrorTyping(){
        $(".mirror-typing").live("keyup",function(e) {
            var obj = $(this),
                message = obj.attr("data-message") || "",
                span = obj.parent().children(":last");
            if(!span.length || !span.hasClass("message")){
                appendMessageToParent(obj);
                span = obj.parent().children(":last");
            }
            span.html(message + obj.val());
            return true;
        });
        
    }

    function appendMessages(){
        $("[data-message]").each(function() {
            var obj = $(this);
            appendMessageToParent(obj)
        });
    }

    function appendMessageToParent(obj){
        obj.parent().append("<span class=\"message\">" + obj.attr("data-message") + "</span>");
    }

    function confirmConfirmable(obj){
        var other = obj.parent().prev().children("input").first();
        return obj.val() == other.val();
    }

    function showValidationErrorsIfNeeded(obj,isValid){
        if(isValid){
            obj.css('background-color','#FFFFFF');
            obj.css('border-color','');
        }
        else {
            obj.css('background-color','#FFEDEF');
            obj.css('border-color','#cc0000');
        }
    }
	
    appendMessages();
    mirrorTyping();

	$('form').live('submit',function(e){
		if($('#navigation .errors').length){
			alert('Please correct the errors in the Form');
            return true;
		}
        if(!checkRequiredCheckBoxes()){
			alert('Please accept the Rules and Terms of Conditions');
            e.preventDefault();
			return false;
		}
	});
	$("fieldset:not(:last-child)").append('<a href="#" class="next-button">Next</a>');

    $("fieldset a").live("click",function(e){
        var current = $(this).parent().index(),
            atag = $('#navigation li a')[current];
        $(atag).click();
        e.preventDefault();
        return false;
    });

    $(".radios input[type=radio]").live("click",function(){
        if($(this).val()=="yes"){
            $(this).parent().siblings().last().attr("disabled","");
        }
        else {
            $(this).parent().siblings().last().attr("disabled","disabled");
        }
    });

    $(".required-for-submit").live("click",function(){
        checkRequiredCheckBoxes();
    });

    $(".confirmable").live("blur",function(e){
		var obj = $(this);
		showValidationErrorsIfNeeded(obj,confirmConfirmable(obj));
    });

    $(".required").each(function(){
        $(this).after("<span class=\"red\">*</span>");
    });
});