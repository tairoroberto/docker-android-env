# Android 7 (SDK 25.X)
- Ant 1.9.6
- Maven 3.3.9
- Java 1.8.0_111
- Gradle 2.10 (Groovy 2.4.5)
- Android SDK 24.4.1
    + APIs: android-10,android-15,android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23,android-24,android-25,android-27
    + Build-Tools: 25.2.3

----
## Tagging scheme
- `v${TOOLS_VERSION}-${BUILD_TOOLS_VERSION}-${HIGHEST_ANDROID_SDK_VERSION}`
- e.g. `v25.2.5-27.0.0-26`
----
### Pull from Docker Hub
```
docker pull tairoroberto/android-env:latest
```

### Build from GitHub
```
docker build -t tairoroberto/android-env github.com/tairoroberto/docker-android-env
```

### Run image
```
docker run -it tairoroberto/android-env bash
```

### Use as base image
```Dockerfile
FROM tairoroberto/android-env:latest
```