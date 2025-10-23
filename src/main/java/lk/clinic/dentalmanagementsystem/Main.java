package lk.clinic.dentalmanagementsystem;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import java.io.File;

public class Main {
    public static void main(String[] args) throws LifecycleException {
        // Create Tomcat instance
        Tomcat tomcat = new Tomcat();

        // Set port
        tomcat.setPort(8080);

        // Get current directory
        String webappDirLocation = "src/main/webapp/";

        // Add webapp
        Context context = tomcat.addWebapp("", new File(webappDirLocation).getAbsolutePath());

        // Set context class loader
        context.setParentClassLoader(Main.class.getClassLoader());

        // Start Tomcat
        tomcat.start();

        System.out.println("\n========================================");
        System.out.println("Dental Management System Started!");
        System.out.println("Access the application at: http://localhost:8080/");
        System.out.println("Press Ctrl+C to stop the server");
        System.out.println("========================================\n");

        // Keep server running
        tomcat.getServer().await();
    }
}