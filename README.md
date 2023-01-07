flutter作为子项目嵌入现有Android程序

# 指定架构

由于Flutter 当前仅支持 为 x86_64，armeabi-v7a 和 arm64-v8a 构建预编（AOT）的库。

考虑使用 abiFilters 这个 Android Gradle 插件 API 来指定 APK 中支持的架构，
从而避免 libflutter.so 无法生成而导致应用运行时崩溃，具体操作如下：

在主项目的build.gradle文件里的android标签的defaultConfig里设置

```
android {
  //...
  defaultConfig {
    ndk {
      // Filter for architectures supported by Flutter.
      abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
    }
  }
}

```

下面是具体设置：

```
    defaultConfig {
        applicationId "com.lgy.androidwithfluttertest"
        minSdk 21
        targetSdk 32
        versionCode 1
        versionName "1.0"
        ndk {
            // Filter for architectures supported by Flutter.
            abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
        }
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }
```

# 创建flutter模块
如果想要在不使用 Flutter 的 Android Studio 插件的情况下手动将 Flutter 模块与现有的 Android 应用集成，

## 创建 Flutter 模块

假设你在 Documents/AndroidWorkspace/AndroidWithFlutterTest 路径下已有一个 Android 应用，并且你希望 Flutter 项目作为同级项目：

```
cd Documents/AndroidWorkspace/AndroidWithFlutterTest
flutter create -t module --org com.example my_flutter
```
这会创建一个 Documents/AndroidWorkspace/AndroidWithFlutterTest/my_flutter/ 的 Flutter 模块项目，其中包含一些 Dart 代码来帮助你入门以及一个隐藏的子文件夹 .android/。 .android 文件夹包含一个 Android 项目，该项目不仅可以帮助你通过 flutter run 运行这个 Flutter 模块的独立应用，而且还可以作为封装程序来帮助引导 Flutter 模块作为可嵌入的 Android 库。

## 将flutter_module设置成子项目
到工程根目录下找到setting.gradle文件，在结尾加上

```
// Include the host app project.
include ':app'                                                          // assumed existing content
setBinding(new Binding([gradle: this]))                                // new
evaluate(new File(                                                     // new
        settingsDir.parentFile,                                              // new
        'AndroidWithFlutterTest/my_flutter/.android/include_flutter.groovy'  // new
))                                                                     // new

```

## 如果你使用的是gradle 6.8

注意：gradle6.8后 settings.gradle新增了如下配置

```
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        jcenter() // Warning: this repository is going to shut down soon
    }
}
```

RepositoriesMode配置在构建中仓库如何设置，总共有三种方式：

```
FAIL_ON_PROJECT_REPOS
表示如果工程单独设置了仓库，或工程的插件设置了仓库，构建就直接报错抛出异常
PREFER_PROJECT
表示如果工程单独设置了仓库，就优先使用工程配置的，忽略settings里面的
PREFER_SETTINGS
表述任何通过工程单独设置或插件设置的仓库，都会被忽略
```

settings.gradle里配置了FAIL_ON_PROJECT_REPOS,而Flutter插件又单独设置了repository，所以会构建报错，因此需要把FAIL_ON_PROJECT_REPOS改成PREFER_PROJECT。

配置如下：

```
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_PROJECT)
    repositories {
        google()
        mavenCentral()
    }
}
```

但此时Android项目本身没有设置仓库，所有的依赖库都会找flutter module中配置的仓库下载依赖。所以需要在项目根目录下的build.gradle中添加

```
//AndroidWithFlutterTest/build.gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

## 主模块依赖flutter

在主模块下的build.gradle依赖flutter
```
//AndroidWithFlutterTest/app/build.gradle
dependencies { 
implementation project(
':flutter'
)
}
```

记住，虽然你的flutter模块名叫做my_flutter,但是主模块写死以来flutter，所以不要写成下面这样：

```
dependencies { 
implementation project(
':my_flutter'
)
```

# 跳转到flutter页面

我们需要在主模块创建一个Actvity,继承FlutterActivity，如下

```java
package com.lgy.androidwithfluttertest;
import io.flutter.embedding.android.FlutterActivity;

public class LgyFlutterActivity extends FlutterActivity{
}
```

这时候，只要跳转到LgyFlutterActivity，就会自动加载my_flutter模块下的lib包里的main.dart

```
                Intent intent = new Intent();
                intent.setClass(MainActivity.this,LgyFlutterActivity.class);
                startActivity(intent);
```


# 参考文章
https://flutter.cn/docs/development/add-to-app/android/project-setup
