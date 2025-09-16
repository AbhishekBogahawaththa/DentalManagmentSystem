import com.dental.util.DBUtil;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("✅ Connected to SQL Server: " + conn.getCatalog());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

