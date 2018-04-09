package de.twometer.protodesign.db;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import de.twometer.protodesign.util.Utils;
import de.twometer.protodesign.vpsl.VPSLParser;
import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;

import java.sql.SQLException;

@DatabaseTable(tableName = "protocolRevisions")
public class ProtocolRevision {

    @DatabaseField(generatedId = true)
    public long sqlId;

    @DatabaseField
    public long protocolId;

    @DatabaseField
    public long revisionNo;

    @DatabaseField
    public long createdBy;

    @DatabaseField
    public long createdOn;

    @DatabaseField
    public String commitMessages;

    @DatabaseField
    public String contents;


    public long getSqlId() {
        return sqlId;
    }

    public long getProtocolId() {
        return protocolId;
    }

    public long getRevisionNo() {
        return revisionNo;
    }

    public long getCreatedBy() {
        return createdBy;
    }

    public String getCreatorName() {
        try {
            return DbAccess.getUserDao().queryForId(getCreatedBy()).email;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "unknown";
    }

    public long getCreatedOn() {
        return createdOn;
    }

    public String getCreatedOnFormatted() {
        return Utils.formatMs(getCreatedOn());
    }

    public String getCommitMessages() {
        return commitMessages;
    }

    public String getContents() {
        return contents;
    }

    public String getHtmlContent() {
        String content = getContents();
        Parser parser = Parser.builder().build();
        Node document = parser.parse(content);
        HtmlRenderer renderer = HtmlRenderer.builder().escapeHtml(false).build();
        return VPSLParser.process(renderer.render(document));
    }

}
