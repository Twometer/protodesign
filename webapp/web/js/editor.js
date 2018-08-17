var $content = $("#inputContent");

var brackets = {
    '{': '}',
    '(': ')',
    '[': ']',
    '<': '>'
};

function findIndentation(currentIdx) {
    currentIdx -= 1;
    var val = $content.val();
    var lineStart = 0;
    for (var i = currentIdx; i > 0; i--) {
        var charCode = val.charCodeAt(i);
        if (charCode === 10 || charCode === 13) {
            lineStart = i;
            break;
        }
    }
    var indent = 0;
    var currentLine = val.substr(lineStart, currentIdx - lineStart);
    for (var i = 0; i < currentLine.length; i++) {
        var charCode = currentLine.charCodeAt(i);
        if (charCode === 32)
            indent++;
        else if (charCode !== 10 && charCode !== 13) break;
    }
    return indent + 1 === currentLine.length ? 0 : indent;
}

function insertText(text, insertion, idx) {
    return text.substring(0, idx) + insertion + text.substring(idx);
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
        var ins = "\n" + indentString;
        $content.val(function (i, text) {
            return insertText(text, ins, idx);
        });
        $(this).prop('selectionStart', idx + ins.length);
        $(this).prop('selectionEnd', idx + ins.length);
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
    } else if (Object.values(brackets).indexOf(e.key) >= 0) {
        if ($(this).val()[$(this).prop('selectionStart')] === e.key) {
            e.preventDefault();
            $this.prop('selectionStart', function (i, t) {
                return t + 1;
            });
            $this.prop('selectionEnd', function (i, t) {
                return t + 1;
            });
        }
    } else if (e.keyCode === 9) {
        e.preventDefault();
        var idx = $(this).prop('selectionStart');
        var indent = findIndentation(idx);
        var indentString = "";
        for (var i = indent + 1; i < 4; i++) {
            indentString += " ";
        }
        $content.val(function (i, text) {
            return insertText(text, indentString, idx);
        });
        $(this).prop('selectionStart', idx + indentString.length);
        $(this).prop('selectionEnd', idx + indentString.length);
    }
});