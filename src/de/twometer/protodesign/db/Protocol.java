package de.twometer.protodesign.db;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import de.twometer.protodesign.util.Utils;

import java.sql.SQLException;
import java.util.List;

@DatabaseTable(tableName = "protocols")
public class Protocol {

    @DatabaseField(id = true)
    public long protocolId;

    @DatabaseField
    public String title;

    @DatabaseField
    public String description;

    @DatabaseField
    public long ownerId;

    @DatabaseField
    public long latestRevision;

    @DatabaseField
    public long lastActive;

    public long getProtocolId() {
        return protocolId;
    }

    public long getOwnerId() {
        return ownerId;
    }

    public long getLatestRevision() {
        return latestRevision;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public long getLastActive() {
        return lastActive;
    }

    public String getLastActiveFormatted() {
        return Utils.formatMs(getLastActive());
    }

    public String getOwnerName() {
        try {
            return DbAccess.getUserDao().queryForId(getOwnerId()).email;
        } catch (SQLException e) {
            e.printStackTrace();
            return "unknown";
        }
    }

    public String getCollaboratorString() {
        try {
            List<ProtocolShareInfo> shareInfoList = DbAccess.getProtocolShareInfoDao().queryForEq("protocolId", protocolId);
            StringBuilder builder = new StringBuilder();
            boolean first = true;
            for (ProtocolShareInfo info : shareInfoList) {
                if (info.sharedUserId == getOwnerId()) continue;
                if (!first) builder.append(";");
                builder.append(DbAccess.getUserDao().queryForId(info.sharedUserId).email);
                first = false;
            }
            return builder.toString();
        } catch (SQLException e) {
            e.printStackTrace();
            return "unknown";
        }
    }
}
