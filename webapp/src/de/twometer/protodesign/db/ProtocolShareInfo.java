package de.twometer.protodesign.db;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "shareInfo")
public class ProtocolShareInfo {

    @DatabaseField(generatedId = true)
    public long shareId;

    @DatabaseField
    public long protocolId;

    @DatabaseField
    public long sharedUserId;

    public ProtocolShareInfo(long protocolId, long sharedUserId) {
        this.protocolId = protocolId;
        this.sharedUserId = sharedUserId;
    }

    public ProtocolShareInfo() {
    }
}
