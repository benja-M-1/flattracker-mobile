package fr.flattracker.

import android.app.Application;
import org.apache.cordova.core.ParsePlugin;

public class MainActivity extends Application
{
    @Override
    public void onCreate() {
        super.onCreate();
        Parse.initialize(this, "MnhiY8j6D89sV6", "9edyLhBY9M93u6");
        ParseInstallation.getCurrentInstallation().saveInBackground();
    }
}
