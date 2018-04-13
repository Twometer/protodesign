package de.twometer.protodesign.db;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;
import de.twometer.protodesign.util.Utils;

import java.sql.SQLException;

public class DbAccess {

    private static ConnectionSource connectionSource;
    private static Dao<User, Long> userDao;
    private static Dao<Protocol, Long> protocolDao;
    private static Dao<ProtocolShareInfo, Long> protocolShareInfoDao;
    private static Dao<ProtocolRevision, Long> protocolRevisionDao;

    private static void openConnection() throws SQLException {
        if (connectionSource == null || userDao == null || protocolDao == null || protocolShareInfoDao == null || protocolRevisionDao == null) {


            String databaseUrl = "jdbc:sqlite:" + Utils.getFilePath("proto-design-storage.db");

            connectionSource = new JdbcConnectionSource(databaseUrl);

            TableUtils.createTableIfNotExists(connectionSource, User.class);
            userDao = DaoManager.createDao(connectionSource, User.class);

            TableUtils.createTableIfNotExists(connectionSource, Protocol.class);
            protocolDao = DaoManager.createDao(connectionSource, Protocol.class);

            TableUtils.createTableIfNotExists(connectionSource, ProtocolShareInfo.class);
            protocolShareInfoDao = DaoManager.createDao(connectionSource, ProtocolShareInfo.class);

            TableUtils.createTableIfNotExists(connectionSource, ProtocolRevision.class);
            protocolRevisionDao = DaoManager.createDao(connectionSource, ProtocolRevision.class);
        }
    }

    public static Dao<User, Long> getUserDao() throws SQLException {
        openConnection();
        return userDao;
    }

    public static Dao<Protocol, Long> getProtocolDao() throws SQLException {
        openConnection();
        return protocolDao;
    }

    public static Dao<ProtocolShareInfo, Long> getProtocolShareInfoDao() throws SQLException {
        openConnection();
        return protocolShareInfoDao;
    }

    public static Dao<ProtocolRevision, Long> getProtocolRevisionDao() throws SQLException {
        openConnection();
        return protocolRevisionDao;
    }
}
