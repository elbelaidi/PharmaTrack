import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class MavenWrapperDownloader {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java MavenWrapperDownloader <url> <outputFile>");
            System.exit(1);
        }

        String url = args[0];
        String outputFile = args[1];

        try {
            System.out.println("Downloading Maven wrapper from " + url);
            URL wrapperUrl = new URL(url);
            Files.copy(wrapperUrl.openStream(), Paths.get(outputFile), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Downloaded Maven wrapper to " + outputFile);
        } catch (Exception e) {
            System.err.println("Error downloading Maven wrapper: " + e.getMessage());
            System.exit(1);
        }
    }
} 