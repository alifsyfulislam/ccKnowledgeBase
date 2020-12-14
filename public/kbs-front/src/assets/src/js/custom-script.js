
;
/*  Resized function
============================================= */
    var waitForFinalEvent = (function () {
        var timers = {};
        return function (callback, ms, uniqueId) {
            if (!uniqueId) {
                uniqueId = "Don't call this twice without a uniqueId";
            }
            if (timers[uniqueId]) {
                clearTimeout (timers[uniqueId]);
            }
            timers[uniqueId] = setTimeout(callback, ms);
        };
    })();


jQuery(document).ready(function($) {
    /*  Window resize function call
    ============================================= */
    $(window).resize(function () {
        waitForFinalEvent(function(){
           
            //responsiveNav();

        }, 500, "some unique string");
    });

    // Login Form 
    $(document).on('focus', '.form-group input', function () {
        $(this).parent().addClass('focused');
    });
    
    $(document).on('blur','.form-group input', function () {
        let inputValue = $(this).val();
        if ( inputValue == "" ) {
            $(this).removeClass('filled');
            $(this).parents('.form-group').removeClass('focused');  
        } else {
            $(this).addClass('filled');
        }
    });

    // Password show hide
    $(document).on('click', '.password-show-hide', function () {
        $(this).toggleClass("show");
        let x = document.getElementById("userPassword");
        if (x.type === "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }
    });

    // Search Box Expand
    // $(document).on('focus', '.search-input-wrapper input', function () {
    $(document).on('focus','.search-input-wrapper input', function(){
        $(this).parent().addClass('focused');
    });

    $(document).on('blur','.search-input-wrapper input', function () {
        let inputValue = $(this).val();
        if ( inputValue == "" ) {
            $(this).removeClass('filled');
            $(this).parents().removeClass('focused');
        } else {
            $(this).addClass('filled');
        }
    });


    // Custom accordion
    $(document).on('click','.custom-accordion .heading', function () {
        $(this).toggleClass("active").next().slideToggle();
        $(".contents").not($(this).next()).slideUp(200);        
        $(this).siblings().removeClass("active");
    });
});