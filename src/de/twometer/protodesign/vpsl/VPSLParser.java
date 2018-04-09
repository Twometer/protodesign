package de.twometer.protodesign.vpsl;

public class VPSLParser {


    public static String process(String html) {

        boolean inCodeBlock = false;

        boolean inDataType = false;

        boolean inComment = false;

        boolean inCondition = false;

        int datatypeApply = -1;

        StringBuilder stringBuilder = new StringBuilder();

        char[] chars = html.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            if (startsAt(chars, "<pre><code class=\"language-vpsl\">", i)) inCodeBlock = true;
            else if (startsAt(chars, "</code></pre>", i)) inCodeBlock = false;
            if (inCodeBlock) {

                if (!inDataType && startsAt(chars, "&lt;", i)) {
                    inDataType = true;
                    datatypeApply = i + "&lt;".length();
                }
                if (!inDataType && (chars[i] == '[' || chars[i] == '{') && (i == 0 || (chars[i - 1] == '>' || chars[i - 1] == ';' || chars[i - 1] == '\n'))) {
                    inDataType = true;
                    datatypeApply = i + 1;
                }
                if (inDataType && datatypeApply == i) {
                    stringBuilder.append(buildHtmlTag("vpsl-datatype", true));
                }
                if (inDataType && chars[i] == ' ') {
                    inDataType = false;
                    stringBuilder.append(buildHtmlTag(null, false));
                }

                if (!inComment && chars[i] == '\'') {
                    stringBuilder.append(buildHtmlTag("vpsl-comment", true));
                    inComment = true;
                }

                if (inComment && chars[i] == '\n') {
                    stringBuilder.append(buildHtmlTag(null, false));
                    inComment = false;
                }

                if (!inCondition && i > 0 && chars[i] == '(' && chars[i - 1] == '(') {
                    stringBuilder.append(buildHtmlTag("vpsl-condition", true));
                    inCondition = true;
                }

                if (inCondition && chars[i] == ')') {
                    stringBuilder.append(buildHtmlTag(null, false));
                    inCondition = false;
                }

                stringBuilder.append(chars[i]);

            } else stringBuilder.append(chars[i]);
        }
        return stringBuilder.toString();
    }

    private static boolean startsAt(char[] a, String target, int idx) {
        char[] b = target.toCharArray();
        int j = 0;
        for (int i = idx; i < a.length; i++) {
            if (j >= b.length) break;
            if (a[i] != b[j])
                return false;
            j++;
        }
        return true;
    }

    private static String buildHtmlTag(String clazz, boolean open) {
        return open ? String.format("<span class=\"%s\">", clazz) : "</span>";
    }
}
