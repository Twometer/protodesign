package de.twometer.protodesign.db;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "users")
public class User {

    @DatabaseField(id = true)
    public long userId;

    @DatabaseField
    public String email;

    @DatabaseField(dataType = DataType.BYTE_ARRAY)
    public byte[] passwordHash;

    public User() {
    }

    public User(long userId, String email, byte[] passwordHash) {
        this.userId = userId;
        this.email = email;
        this.passwordHash = passwordHash;
    }
}

