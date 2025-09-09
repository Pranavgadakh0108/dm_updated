# Keep WorkManager classes
-keep class androidx.work.** { *; }
-keepclassmembers class androidx.work.** { *; }

# Keep Awesome Notifications
-keep class com.awesome_notifications.** { *; }
-keep class * extends com.awesome_notifications.core.broadcasters.NotificationActionReceiver { *; }
-keep class * extends com.awesome_notifications.core.broadcasters.NotificationDismissedReceiver { *; }

# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep your application classes
-keep class com.example.dmboss.** { *; }
-keep class com.example.dmboss.MainApplication { *; }

# Keep callback methods with @pragma('vm:entry-point')
-keepclassmembers class * {
    @pragma('vm:entry-point') *;
}

# Keep JSON serialization classes
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep Dart service classes
-keep class * extends dart.core._NativeFieldWrapperClass { *; }

# Prevent obfuscation of method names
-keepnames class * {
    public void callbackDispatcher(...);
    public void _executeBackgroundCheck(...);
}

# WorkManager workers
-keep class * extends androidx.work.Worker {
    public <init>(android.content.Context, androidx.work.WorkerParameters);
}