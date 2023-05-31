// File#: _1_back-to-top
// Usage: codyhouse.co/license
(function () {
    var backTop = document.getElementsByClassName('js-back-to-top')[0];
    if (backTop) {
        var dataElement = backTop.getAttribute('data-element');
        var scrollElement = dataElement ? document.querySelector(dataElement) : window;
        var scrollOffsetInit = parseInt(backTop.getAttribute('data-offset-in')) || parseInt(backTop.getAttribute('data-offset')) || 0, //show back-to-top if scrolling > scrollOffset
            scrollOffsetOutInit = parseInt(backTop.getAttribute('data-offset-out')) || 0,
            scrollOffset = 0,
            scrollOffsetOut = 0,
            scrolling = false;

        // check if target-in/target-out have been set
        var targetIn = backTop.getAttribute('data-target-in') ? document.querySelector(backTop.getAttribute('data-target-in')) : false,
            targetOut = backTop.getAttribute('data-target-out') ? document.querySelector(backTop.getAttribute('data-target-out')) : false;

        updateOffsets();

        //detect click on back-to-top link
        backTop.addEventListener('click', function (event) {
            event.preventDefault();
            if (!window.requestAnimationFrame) {
                scrollElement.scrollTo(0, 0);
            } else {
                dataElement ? scrollElement.scrollTo({ top: 0, behavior: 'smooth' }) : window.scrollTo({ top: 0, behavior: 'smooth' });
            }
            //move the focus to the #top-element - don't break keyboard navigation
            moveFocus(document.getElementById(backTop.getAttribute('href').replace('#', '')));
        });

        //listen to the window scroll and update back-to-top visibility
        checkBackToTop();
        if (scrollOffset > 0 || scrollOffsetOut > 0) {
            scrollElement.addEventListener("scroll", function (event) {
                if (!scrolling) {
                    scrolling = true;
                    (!window.requestAnimationFrame) ? setTimeout(function () { checkBackToTop(); }, 250) : window.requestAnimationFrame(checkBackToTop);
                }
            });
        }

        function checkBackToTop() {
            updateOffsets();
            var windowTop = scrollElement.scrollTop || document.documentElement.scrollTop;
            if (!dataElement) windowTop = window.scrollY || document.documentElement.scrollTop;
            var condition = windowTop >= scrollOffset;
            if (scrollOffsetOut > 0) {
                condition = (windowTop >= scrollOffset) && (window.innerHeight + windowTop < scrollOffsetOut);
            }
            backTop.classList.toggle('back-to-top--is-visible', condition);
            scrolling = false;
        }

        function updateOffsets() {
            scrollOffset = getOffset(targetIn, scrollOffsetInit, true);
            scrollOffsetOut = getOffset(targetOut, scrollOffsetOutInit);
        }

        function getOffset(target, startOffset, bool) {
            var offset = 0;
            if (target) {
                var windowTop = scrollElement.scrollTop || document.documentElement.scrollTop;
                if (!dataElement) windowTop = window.scrollY || document.documentElement.scrollTop;
                var boundingClientRect = target.getBoundingClientRect();
                offset = bool ? boundingClientRect.bottom : boundingClientRect.top;
                offset = offset + windowTop;
            }
            if (startOffset && startOffset) {
                offset = offset + parseInt(startOffset);
            }
            return offset;
        }

        function moveFocus(element) {
            if (!element) element = document.getElementsByTagName("body")[0];
            element.focus();
            if (document.activeElement !== element) {
                element.setAttribute('tabindex', '-1');
                element.focus();
            }
        };
    }
}());

// File#: _1_chameleonic-header
// Usage: codyhouse.co/license
(function () {
    var ChaHeader = function (element) {
        this.element = element;
        this.sections = document.getElementsByClassName('js-cha-section');
        this.header = this.element.getElementsByClassName('js-cha-header')[0];
        // handle mobile behaviour
        this.headerTrigger = this.element.getElementsByClassName('js-cha-header__trigger');
        this.modal = document.getElementsByClassName('js-cha-modal');
        this.focusMenu = false;
        this.firstFocusable = null;
        this.lastFocusable = null;
        this.visibleClass = 'cd-block';
        initChaHeader(this);
    };

    function initChaHeader(element) {
        // set initial status
        for (var j = 0; j < element.sections.length; j++) {
            initSection(element, j);
        }

        // handle mobile behaviour
        if (element.headerTrigger.length > 0) {
            initMobileVersion(element);
        }

        // make sure header element is visible when in focus
        element.header.addEventListener('focusin', function (event) {
            checkHeaderVisible(element);
        });
    };

    function initSection(element, index) {
        // clone header element inside each section
        var cloneItem = (index == 0) ? element.element : element.element.cloneNode(true);
        cloneItem.classList.remove('js-cha-header-clip');
        var customClasses = element.sections[index].getAttribute('data-header-class');
        // hide clones to SR
        cloneItem.setAttribute('aria-hidden', 'true');
        if (customClasses) addHeaderClass(cloneItem.getElementsByClassName('js-cha-header')[0], customClasses);
        // keyborad users - make sure cloned items are not tabbable
        if (index != 0) {
            // reset tab index
            resetTabIndex(cloneItem);
            element.sections[index].insertBefore(cloneItem, element.sections[index].firstChild);
        }
    }

    function addHeaderClass(el, classes) {
        var classList = classes.split(' ');
        el.classList.add(classList[0]);
        if (classList.length > 1) addHeaderClass(el, classList.slice(1).join(' '));
    };

    function resetTabIndex(clone) {
        var focusable = clone.querySelectorAll('[href], button, input');
        for (var i = 0; i < focusable.length; i++) {
            focusable[i].setAttribute('tabindex', '-1');
        }
    };

    function initMobileVersion(element) {
        //detect click on nav trigger
        var triggers = document.getElementsByClassName('js-cha-header__trigger');
        for (var i = 0; i < triggers.length; i++) {
            triggers[i].addEventListener("click", function (event) {
                event.preventDefault();
                var ariaExpanded = !element.modal[0].classList.contains(element.visibleClass);
                //show nav and update button aria value
                element.modal[0].classList.toggle(element.visibleClass, ariaExpanded);
                element.headerTrigger[0].setAttribute('aria-expanded', ariaExpanded);
                if (ariaExpanded) { //opening menu -> move focus to first element inside nav
                    getFocusableElements(element);
                    element.firstFocusable.focus();
                } else if (element.focusMenu) {
                    if (window.scrollY < element.focusMenu.offsetTop) element.focusMenu.focus();
                    element.focusMenu = false;
                }
            });
        }

        // close modal on click
        element.modal[0].addEventListener("click", function (event) {
            if (!event.target.closest('.js-cha-modal__close')) return;
            closeModal(element);
        });

        // listen for key events
        window.addEventListener('keydown', function (event) {
            // listen for esc key
            if ((event.keyCode && event.keyCode == 27) || (event.key && event.key.toLowerCase() == 'escape')) {
                // close navigation on mobile if open
                if (element.headerTrigger[0].getAttribute('aria-expanded') == 'true' && isVisible(element.headerTrigger[0])) {
                    closeModal(element);
                }
            }
            // listen for tab key
            if ((event.keyCode && event.keyCode == 9) || (event.key && event.key.toLowerCase() == 'tab')) {
                trapFocus(element, event);
            }
        });
    };

    function closeModal(element) {
        element.focusMenu = element.headerTrigger[0]; // move focus to menu trigger when menu is close
        element.headerTrigger[0].click();
    };

    function trapFocus(element, event) {
        if (element.firstFocusable == document.activeElement && event.shiftKey) {
            //on Shift+Tab -> focus last focusable element when focus moves out of modal
            event.preventDefault();
            element.lastFocusable.focus();
        }
        if (element.lastFocusable == document.activeElement && !event.shiftKey) {
            //on Tab -> focus first focusable element when focus moves out of modal
            event.preventDefault();
            element.firstFocusable.focus();
        }
    };

    function getFocusableElements(element) {
        //get all focusable elements inside the modal
        var allFocusable = element.modal[0].querySelectorAll('[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, [tabindex]:not([tabindex="-1"]), [contenteditable], audio[controls], video[controls], summary');
        getFirstVisible(element, allFocusable);
        getLastVisible(element, allFocusable);
    };

    function getFirstVisible(element, elements) {
        //get first visible focusable element inside the modal
        for (var i = 0; i < elements.length; i++) {
            if (elements[i].offsetWidth || elements[i].offsetHeight || elements[i].getClientRects().length) {
                element.firstFocusable = elements[i];
                return true;
            }
        }
    };

    function getLastVisible(element, elements) {
        //get last visible focusable element inside the modal
        for (var i = elements.length - 1; i >= 0; i--) {
            if (elements[i].offsetWidth || elements[i].offsetHeight || elements[i].getClientRects().length) {
                element.lastFocusable = elements[i];
                return true;
            }
        }
    };

    function checkHeaderVisible(element) {
        if (window.scrollY > element.sections[0].offsetHeight - element.header.offsetHeight) window.scrollTo(0, 0);
    };

    function isVisible(element) {
        return (element.offsetWidth || element.offsetHeight || element.getClientRects().length);
    };

    // init the ChaHeader Object
    var chaHader = document.getElementsByClassName('js-cha-header-clip'),
        clipPathSupported = CSS.supports('clip-path', 'polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)') || CSS.supports('-webkit-clip-path', 'polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)');
    if (chaHader.length > 0 && clipPathSupported) {
        for (var i = 0; i < chaHader.length; i++) {
            new ChaHeader(chaHader[i]);
        }
    }
}());

// File#: _1_pre-header
// Usage: codyhouse.co/license
// utility functions
if(!Util) function Util () {};

Util.addClass = function(el, className) {
  var classList = className.split(' ');
  el.classList.add(classList[0]);
  if (classList.length > 1) Util.addClass(el, classList.slice(1).join(' '));
};
(function() {
	var preHeader = document.getElementsByClassName('js-pre-header');
	if(preHeader.length > 0) {
		for(var i = 0; i < preHeader.length; i++) {
			(function(i){ addPreHeaderEvent(preHeader[i]);})(i);
		}

		function addPreHeaderEvent(element) {
			var close = element.getElementsByClassName('js-pre-header__close-btn')[0];
			if(close) {
				close.addEventListener('click', function(event) {
					event.preventDefault();
					Util.addClass(element, 'pre-header--is-hidden');
				});
			}
		}
	}
}());