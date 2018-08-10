var inResponsiveMode = false;
var threshold = 576;
var initialStates = [];

window.onresize = function (ev) {
    checkForUpdate();
};


initialize();
checkForUpdate();

function initialize() {
    $(".responsive").each(function () {
        var e = $(this);
        initialStates.push({
            elem: e,
            oldHtml: e.html()
        });
    })
}

function checkForUpdate() {
    if (window.innerWidth < threshold && !inResponsiveMode) {
        inResponsiveMode = true;
        updateButtons();
    } else if (window.innerWidth >= threshold && inResponsiveMode) {
        inResponsiveMode = false;
        updateButtons();
    }
}

function updateButtons() {
    for (var i = 0; i < initialStates.length; i++) {
        var state = initialStates[i];
        if (inResponsiveMode) {
            state.elem.html('<i class="' + state.elem.data("responsive-icon") + '"></i>')
        } else {
            state.elem.html(state.oldHtml);
        }
    }
}