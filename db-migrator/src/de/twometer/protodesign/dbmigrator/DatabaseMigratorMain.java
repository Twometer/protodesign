package de.twometer.protodesign.dbmigrator;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseMigratorMain {

    /**
     * Migrates an existing protodesign database
     * to the new version so that it has the "theme" field
     */
    public static void main(String[] args) throws SQLException {
        if (args.length < 1) {
            System.err.println("Syntax: db-migrator.jar <database-path>");
            return;
        }
        File file = new File(args[0]);
        if (!file.exists()) {
            System.err.println("The given file does not exist.");
            return;
        }
        Connection connection = DriverManager.getConnection("jdbc:sqlite:" + file.getAbsolutePath());
        connection.createStatement().execute("ALTER TABLE users ADD COLUMN theme INT");
        connection.close();
        System.out.print("Done.");
    }

}
