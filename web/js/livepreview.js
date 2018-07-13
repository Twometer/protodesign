var contentCtl = $("#inputContent");
var previewCtl = $("#preview");
var placeholder = previewCtl.html();

previewCtl.outerHeight(contentCtl.innerHeight());

contentCtl.on('scroll', scrollUpdate);

contentCtl.on('input', function (e) {
    scrollUpdate();
});

$(reload());

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