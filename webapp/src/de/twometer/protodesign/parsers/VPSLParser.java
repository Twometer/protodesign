package de.twometer.protodesign.parsers;

import de.twometer.protodesign.util.CodeScanner;

import static de.twometer.protodesign.util.ParserUtils.buildHtmlTag;
import static de.twometer.protodesign.util.ParserUtils.startsAt;

public class VPSLParser implements IParser {

    private class State {
        boolean inDataType = false;
        boolean inComment = false;
        boolean inCondition = false;
        int datatypeApply = -1;
    }

    @Override
    public String process(String html) {
        State state = new State();
        return CodeScanner.scan(html, "vpsl", (data, i, output) -> {
            if (!state.inDataType && startsAt(data, "&lt;", i)) {
                state.inDataType = true;
                state.datatypeApply = i + "&lt;".length();
            }
            if (!state.inDataType && (data[i] == '[' || data[i] == '{') && (i == 0 || (data[i - 1] == '>' || data[i - 1] == ';' || data[i - 1] == '\n'))) {
                state.inDataType = true;
                state.datatypeApply = i + 1;
            }
            if (state.inDataType && state.datatypeApply == i) {
                output.append(buildHtmlTag("vpsl-datatype", true));
            }
            if (state.inDataType && data[i] == ' ') {
                state.inDataType = false;
                output.append(buildHtmlTag(null, false));
            }

            if (!state.inComment && data[i] == '\'') {
                output.append(buildHtmlTag("vpsl-comment", true));
                state.inComment = true;
            }

            if (state.inComment && data[i] == '\n') {
                output.append(buildHtmlTag(null, false));
                state.inComment = false;
            }

            if (!state.inCondition && i > 0 && data[i] == '(' && data[i - 1] == '(') {
                output.append(buildHtmlTag("vpsl-condition", true));
                state.inCondition = true;
            }

            output.append(data[i]);

            if (state.inCondition && data[i] == ')') {
                output.append(buildHtmlTag(null, false));
                state.inCondition = false;
            }
        });
    }
}
