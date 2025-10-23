package lk.clinic.dentalmanagementsystem;

import org.apache.catalina.Context;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

import java.io.File;

public class RunApplication {

    public static void main(String[] args) throws Exception {

        System.out.println("Starting Dental Management System...");

        // Create Tomcat server
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);

        // Create temp directory
        String tempDir = "target/tomcat-temp";
        new File(tempDir).mkdirs();
        tomcat.setBaseDir(tempDir);

        // Get the web app directory
        String webappDir = new File("src/main/webapp").getAbsolutePath();
        String classesDir = new File("target/classes").getAbsolutePath();

        System.out.println("Webapp dir: " + webappDir);
        System.out.println("Classes dir: " + classesDir);

        // Add webapp
        Context ctx = tomcat.addWebapp("", webappDir);

        // Add classes directory
        WebResourceRoot resources = new StandardRoot(ctx);
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                classesDir, "/"));
        ctx.setResources(resources);

        // Start server
        tomcat.start();

        System.out.println("\n============================================");
        System.out.println("✅ Dental Management System Started!");
        System.out.println("============================================");
        System.out.println("Access the application at:");
        System.out.println("  http://localhost:8080/");
        System.out.println("  http://localhost:8080/test");
        System.out.println("  http://localhost:8080/login");
        System.out.println("============================================");
        System.out.println("Press Ctrl+C to stop the server");
        System.out.println("============================================\n");

        tomcat.getServer().await();
    }
}