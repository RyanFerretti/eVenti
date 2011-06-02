$(function() {
	/*
	number of fieldsets
	*/
	var fieldsetCount = $('form').children().length;
	
	/*
	current position of fieldset / navigation link
	*/
	var current 	= 1;
    
	/*
	sum and save the widths of each one of the fieldsets
	set the final sum as the total width of the steps element
	*/
	var stepsWidth	= 0;
    var widths 		= new Array();
	$('#steps .step').each(function(i){
        var $step 		= $(this);
		widths[i]  		= stepsWidth;
        stepsWidth	 	+= $step.width();
    });
	$('#steps').width(stepsWidth);
	
	/*
	to avoid problems in IE, focus the first input of the form
	*/
	$('form').children(':first').find(':input:first').focus();
	
	/*
	show the navigation bar
	*/
	$('#navigation').show();
	
	/*
	when clicking on a navigation link 
	the form slides to the corresponding fieldset
	*/
    $('#navigation a').bind('click',function(e){
		var $this	= $(this);
		var prev	= current;
        var isValid = true;
		$this.closest('ul').find('li').removeClass('selected');
        $this.parent().addClass('selected');
		/*
		we store the position of the link
		in the current variable	
		*/
		current = $this.parent().index() + 1;
		/*
		animate / slide to the next or to the corresponding
		fieldset. The order of the links in the navigation
		is the order of the fieldsets.
		Also, after sliding, we trigger the focus on the first 
		input element of the new fieldset
		If we clicked on the last link (confirmation), then we validate
		all the fieldsets, otherwise we validate the previous one
		before the form slided
		*/

	    if(current == fieldsetCount) {
		    isValid = validateSteps();
        }
		else {
			isValid = validateStep(prev);
        }
        if(!isValid){
		    $('form').children(':nth-child('+ parseInt(current) +')').find(':input:first').focus();
            $('#steps').stop().animate({ marginLeft: '-' + widths[current-1] + 'px' },500);
        }
        e.preventDefault();
    });
	
	/*
	clicking on the tab (on the last input of each fieldset), makes the form
	slide to the next step
	*/
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
	
	/*
	validates errors on all the fieldsets
	records if the Form has errors in $('#formElem').data()
	*/
	function validateSteps(){
		var FormErrors = false;
		for(var i = 1; i < fieldsetCount; ++i){
			var error = validateStep(i);
			if(error == -1)
				FormErrors = true;
		}
		$('form').data('errors',FormErrors);
        return FormErrors;
	}
	
	/*
	validates one fieldset
	and returns -1 if errors found, or 1 if not
	*/
	function validateStep(step){
        step++;
		if(step == fieldsetCount) return;
		var error = 1;
		var hasError = false;
		$('form').children(':nth-child('+ parseInt(step) +')').find(':input:not(button)').each(function(){
			var $this 		= $(this);
			var valueLength = jQuery.trim($this.val()).length;
            var isValid = valueLength != '';
            if($this.hasClass("confirmable")){
                isValid = isValid && confirmConfirmable($this);
            }
			validateObject($this,isValid);
            if(!isValid){
               hasError = true;
            }
		});
		var $link = $('#navigation li:nth-child(' + parseInt(step-1) + ') a');
		$link.parent().find('.error,.checked').remove();
		
		var valclass = 'checked';
		if(hasError){
			error = -1; 
			valclass = 'error';
		}
		$('<span class="'+valclass+'"></span>').insertAfter($link);
		
		return error;
	}
	
	/*
	if there are errors don't allow the user to submit
	*/
	$('form').live('submit',function(e){
		if($('#navigation .errors').length){
			alert('Please correct the errors in the Form');
            //e.preventDefault();
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

    appendMessages();
    mirrorTyping();

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

    $(".confirmable").live("blur",function(e){
        confirmConfirmable($(this));
    });

    function confirmConfirmable(obj){
        var other = obj.parent().prev().children("input").first();
        return validateObject(obj,obj.val() == other.val());
    }

    function validateObject(obj,isValid){
        if(!isValid){
            obj.css('background-color','#FFEDEF');
            obj.css('border-color','#cc0000');
        }
        else {
            obj.css('background-color','#FFFFFF');
            obj.css('border-color','');
        }
        return isValid;
    }

    $(".required").each(function(){
        $(this).after("<span class=\"red\">*</span>");
    });
});