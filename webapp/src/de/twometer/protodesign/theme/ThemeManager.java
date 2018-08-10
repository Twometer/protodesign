package de.twometer.protodesign.theme;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.User;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class ThemeManager {

    private static final String[] availableThemes = new String[]{
            "Default",
            "Bootstrap",
            "Ice",
            "Simplex",
            "Sketchy",
            "Dark"
    };

    public static List<String> getAvailableThemes() {
        return Arrays.asList(availableThemes);
    }

    public static String getThemeCode(User user) {
        return availableThemes[user.theme].toLowerCase();
    }

    public static void changeTheme(User user, String newTheme) throws SQLException {
        int idx = 0;
        for (String theme : availableThemes) {
            if (theme.equalsIgnoreCase(newTheme)) {
                user.theme = idx;
                DbAccess.getUserDao().update(user);
                return;
            }
            idx++;
        }
    }

}
