# Flutter
-keep class io.flutter.** { *; }

# Flutter engine references Play Core for deferred components — this app doesn't use
# dynamic delivery so these classes are absent. Suppress the R8 missing-class errors.
-dontwarn com.google.android.play.core.**

# Dio
-keep class io.github.lizhangqu.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# Hive
-keep class hive.** { *; }
-keep class com.hivedb.** { *; }
-keepclassmembers class * extends com.hivedb.HiveObject { *; }

# dio_cache_interceptor
-keep class com.dhaval2404.** { *; }

# flutter_secure_storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }
