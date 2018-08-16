var $content = $("#inputContent");

var brackets = {
    '{' : '}',
    '(' : ')',
    '[' : ']',
    '<' : '>'
};

function findIndentation(currentIdx) {
    var val = $content.val();
    var lines = val.split('\n');
    var theLine = lines[lines.length - 1];
    var indent = 0;
    for (var i = 0; i < theLine.length; i++) {
        if (theLine[i] === ' ')
            indent++;
        else break;
    }
    return indent;
}

$content.bind('keydown', function (e) {
    if (e.key === "Enter") {
        e.preventDefault();
        var idx = $(this).prop('selectionStart');
        var indent = findIndentation(idx);
        var indentString = "";
        for (var i = 0; i < indent; i++) {
            indentString += " ";
        }
        $content.val(function (i, text) {
            return text + "\n" + indentString;
        });
    } else if (brackets.hasOwnProperty(e.key)) {
        e.preventDefault();
        $content.val(function (i, text) {
            return text + e.key + brackets[e.key];
        });
        $this = $(this);
        $this.prop('selectionStart', function (i, t) {
            return t - 1;
        });
        $this.prop('selectionEnd', function (i, t) {
            return t - 1;
        });
    }
});