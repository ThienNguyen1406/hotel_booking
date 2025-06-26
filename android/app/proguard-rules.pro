#############################
# Flutter & General Rules
#############################

# Giữ lại các class được Flutter dùng qua reflection
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

#############################
# Stripe SDK
#############################

# Giữ toàn bộ class trong Stripe
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# Đặc biệt giữ lại phần push provisioning (đang lỗi ở bạn)
-keep class com.stripe.android.pushProvisioning.** { *; }

# Giữ lại các class từ plugin React Native Stripe (nếu dùng)
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**

#############################
# Google/Firebase (nếu dùng)
#############################

# Firebase core
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

#############################
# Kotlin
#############################

# Giữ lại class Kotlin để tránh lỗi runtime
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Keep coroutines
-keepclassmembers class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**

#############################
# Debug / Annotation
#############################

# Annotation (nếu dùng Dagger/Hilt hoặc ViewBinding)
-keepattributes *Annotation*

# Giữ Log để debug nếu cần
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}
