var contentCtl = $("#inputContent");
var previewCtl = $("#preview");
var placeholder = previewCtl.html();
var inResponsiveMode = true;
var threshold = 992;
var showPreview = false;

window.onresize = function (ev) {
    checkViewSwitcher();
};

previewCtl.outerHeight(contentCtl.innerHeight());

contentCtl.on('scroll', scrollUpdate);

contentCtl.on('input', function (e) {
    scrollUpdate();
});

$(reload());
checkViewSwitcher();
updateView();

var lastVal;

setInterval(function (e) {
    if (contentCtl.val() !== lastVal) {
        reload();
        lastVal = contentCtl.val();
    }
}, 2000);

function reload() {
    var content = contentCtl.val();
    $.post("format", content, function (data) {
        previewCtl.html(data);
        if (previewCtl.html() === '') {
            previewCtl.html(placeholder);
        }
    });
}

function scrollUpdate() {
    var pcx = contentCtl.scrollTop() / (contentCtl[0].scrollHeight - contentCtl.innerHeight());
    previewCtl.scrollTop(pcx * (previewCtl[0].scrollHeight - previewCtl.innerHeight()));
}

function checkViewSwitcher() {
    if (window.innerWidth < threshold && !inResponsiveMode) {
        inResponsiveMode = true;
        updateButtons();
    } else if (window.innerWidth >= threshold && inResponsiveMode) {
        inResponsiveMode = false;
        updateButtons();
    }
}

function updateButtons() {
    if (inResponsiveMode) {
        $("#view-switcher").show();
        updateView();
    } else {
        $("#view-switcher").hide();
        $("#view-markdown").show();
        $("#view-preview").show();
    }
}

function updateView() {
    if(!inResponsiveMode) return;
    if(showPreview){
        $("#view-markdown").hide();
        $("#view-preview").show();
    }else{
        $("#view-markdown").show();
        $("#view-preview").hide();
    }
}

$("#btn-vs-markdown").click(function () {
    showPreview = false;
    $("#btn-vs-markdown").addClass('btn-primary');
    $("#btn-vs-preview").removeClass('btn-primary');
    updateView();
});

$("#btn-vs-preview").click(function () {
    showPreview = true;
    $("#btn-vs-markdown").removeClass('btn-primary');
    $("#btn-vs-preview").addClass('btn-primary');
    updateView();
});

