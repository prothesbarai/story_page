# 📖 Story Page

🚀 A lightweight **Flutter** widget for creating Instagram/Snapchat-like **story sections** in your apps.

---

## ✨ Features
- 📱 **Cross-platform**: Works on Android, iOS, and Web
- 🎨 **Customizable**: Add images, texts, or custom widgets
- 👆 **Gesture support**: Tap right ➡️ next, tap left ⬅️ previous
- ⏱ **Progress indicators** with adjustable duration
- 🔄 Callbacks for `onComplete`, `onStoryChange`, etc.

---


### 📥 Clone the Repository
```bash
git clone https://github.com/prothesbarai/story_page.git
```

## Screenshots
<p float="left">
  <img src="assets/images/img.png" width="200" />
  <img src="assets/images/img_1.png" width="200" />
  <img src="assets/images/img_2.png" width="200" />
</p>


# System Splash Screen Modify With Color And Logo..
## Step - 1
- Create a values-v31 folder  >  in path     android/app/src/main/res/
- so final path is :     /android/app/src/main/res/values-v31/
- Now create a styles.xml file in this path so : /android/app/src/main/res/values-v31/styles.xml
- now write this code in this file
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Android 12+ splash API parent tools -->
    <style name="LaunchTheme" parent="Theme.SplashScreen">
        <item name="windowSplashScreenBackground">@color/my_custom_bg</item>
        <item name="windowSplashScreenAnimatedIcon">@mipmap/ic_launcher</item>
        <item name="postSplashScreenTheme">@style/NormalTheme</item>
    </style>
</resources>
```

## Step - 2
- Create a colors.xml file in this path /android/app/src/main/res/values/
- So :  /android/app/src/main/res/values/colors.xml
- Now Write Code in this file :
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="my_custom_bg">#f4b356</color>
</resources>
```


## Step - 3
- Open     /android/app/build.gradle.kts  file
- And Write Code at last position
```kotlin
dependencies {
    implementation("androidx.core:core-splashscreen:1.0.1")
}
```
