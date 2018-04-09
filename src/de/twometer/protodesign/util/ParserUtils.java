package de.twometer.protodesign.util;

public class ParserUtils {

    public static boolean startsAt(char[] a, String target, int idx) {
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

    public static String buildHtmlTag(String clazz, boolean open) {
        return open ? String.format("<span class=\"%s\">", clazz) : "</span>";
    }

}
