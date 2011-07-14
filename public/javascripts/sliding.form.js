$(function() {

	var fieldsetCount = $('form').children().length,
		current	= 0,
		stepsWidth = 0,
		widths = new Array(),
        ajaxErrorClass = "ajax-validation-error";
		
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
		current = $this.parent().index('li');
		
		// validate all if at the end
	    if(current == (fieldsetCount-1)) {
		    isValid = validateSteps(1,fieldsetCount);
        }
		else {
			isValid = validateSteps(prev,current,true);
        }

        if(isValid || (current < prev)){
			// set selected tab
			$this.closest('ul').find('li').removeClass('selected');
			$this.parent().addClass('selected');
			// focus on first input
		    //$($('form').children('fieldset')[current]).find(':input:first').focus(); // not working
			// animate
            $('#steps').stop().animate({ marginLeft: '-' + widths[current] + 'px' },500);
        }
		else {
			current = prev
		}
        e.preventDefault();
    });
	
	// pressing tab on the last input will slide to the next fieldset
	$('form > fieldset').each(function(){
		var $fieldset = $(this);
		$fieldset.find(':input:last').keydown(function(e){
			if (e.which == 9){
				$('#navigation li:nth-child(' + (parseInt(current)+1) + ') a').click();
				/* force the blur for validation */
				$(this).blur();
				e.preventDefault();
			}
		});
	});
	
	// validates errors on all the fieldsets
	function validateSteps(start,end,stopOnError){
		var isValid = true;
		for(var i = start; i < end; ++i){
			if(!validateStep(i)){
				isValid = false;
                if(stopOnError){
                    break;
                }
			}
		}
		$('form').data('errors',!isValid);
        return isValid;
	}
	
	// validates one fieldset
	function validateStep(step){
        var isValid = true,
			link = $('#navigation li:nth-child(' + (step+1) + ') a'),
			valclass = 'checked';
		if(step == fieldsetCount){
			return true;
		}
		$($('form').children('fieldset')[step]).find(':input:not(button)').each(function(){
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
			val = jQuery.trim(obj.val()),
            phoneRegex = /^\d{3}\-\d{3}\-\d{4}$/;
        // server-side validation already done
        if(obj.hasClass(ajaxErrorClass)){
            return false;
        }
		// required
		if(obj.hasClass("required")){
			isValid = isValid && val != "";
		}
		// confirmed
		if(obj.hasClass("confirmable")){
			isValid = isValid && confirmConfirmable(obj);
		}
        // phone
		if(obj.hasClass("phone") && obj.val().length > 0){
			isValid = isValid && obj.val().match(phoneRegex);
		}
		showValidationErrorsIfNeeded(obj,isValid);
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
            e.preventDefault();
			return false;
		}
        if(!checkRequiredCheckBoxes()){
			alert('Please accept the Rules and Terms of Conditions');
            e.preventDefault();
			return false;
		}
        if(!validateCaptcha()){
            alert('Please correct the captcha and try again');
            e.preventDefault();
			return false;
		}
        return true;
	});
	$("fieldset:not(:last-child)").append('<a href="#" class="next-button">Next</a>');

    $("fieldset a").live("click",function(e){
        var current_fieldset = $(this).parent().index('fieldset'),
            atag = $('#navigation li a')[current_fieldset+1]; // go to next
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

    $("input:not(button), select").live("blur",function(e){
        validateInput($(this));
    });

    $(".required").each(function(){
        var obj = $(this);
        if(obj.parent().children("span.red").length == 0){
            obj.after("<span class=\"red right\">*</span>");
        }
    });

    $(".birthday-picker").datepicker({
        defaultDate: "-22y",
        maxDate: "-21y",
        changeMonth: true,
		changeYear: true,
        onClose: function(dateText, inst) { validateInput($(this)); }
    });

    $("[data-unique]").live("blur",function(e){
        var obj = $(this),
            name = obj.attr("name"),
            loadingClass = "ajax-loading";
        if(obj.val().length > 0){
            obj.addClass(loadingClass);
            $.ajax(obj.attr("data-unique"),{
                data:{ val:obj.val() },
                success:function(data){
                    var uniqueErrorClass = "unique-error";
                    showValidationErrorsIfNeeded(obj,data.valid);
                    obj.removeClass(loadingClass);
                    if(data.valid){
                        obj.removeClass(ajaxErrorClass);
                        if(obj.parent().children("span."+uniqueErrorClass).length != 0){
                            obj.next().next().remove();
                        }
                    }
                    else {
                        obj.addClass(ajaxErrorClass);
                        if(obj.parent().children("span."+uniqueErrorClass).length == 0){
                            obj.next().after("<span class=\"red message "+uniqueErrorClass+"\">"+data.error+"</span>");
                        }
                    }
                }
            });
        }
    });

    function getParam(name) {
        var param = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
            regexS = "[\\?&]"+param+"=([^&#]*)";
            regex = new RegExp(regexS);
            results = regex.exec(window.location.href);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    function moveToStep(){
        var step = $("#recaptcha_error").val();
        if(step){
            // don't care about the step now... only error will be captcha on the last step
            $('#navigation a.captcha').click();
            // visually show file inputs in red
            $('form').children('fieldset:last').find('input[type="file"]').each(function(){
                showValidationErrorsIfNeeded($(this),false);
		    });
        }
    }

    moveToStep();

    $("form").live("keypress", function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            return false;
        }
    });

    function validateCaptcha() {
        var obj = $("#recaptcha_response_field"),
            challenge = $("#recaptcha_challenge_field"),
            name = obj.attr("name"),
            challenge_name = challenge.attr("name"),
            loadingClass = "ajax-loading",
            data_values = {}
            isSuccess = false;
        if(obj.val().length > 0){
            obj.addClass(loadingClass);
            data_values[name] = obj.val();
            data_values[challenge_name] = challenge.val();
            $.ajax("/captcha/verify",{
                data:data_values,
                success: function(data){
                        var captchaErrorClass = "captcha-error";
                        showValidationErrorsIfNeeded(obj,data.valid);
                        obj.removeClass(loadingClass);
                        if(data.valid){
                            obj.removeClass(ajaxErrorClass);
                            if(obj.parent().children("span."+captchaErrorClass).length != 0){
                                obj.next().next().remove();
                            }
                            isSuccess = true;
                        }
                        else {
                            obj.addClass(ajaxErrorClass);
                            if(obj.parent().children("span."+captchaErrorClass).length == 0){
                                obj.next().after("<span class=\"red message "+captchaErrorClass+"\">"+data.error+"</span>");
                            }
                        }

                    },
                async:false
            });
        }
        console.log(isSuccess);
        return isSuccess;
    }
});