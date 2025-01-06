# native_progress_indicator

Flutter progress indicators animation can be blocking and have negative impacts on performance.

This library replaces flutter `CircularProgressIndicator` and `LinearProgressIndicator` with a platform view implementation.


# Demo:

![demo](https://github.com/cedvdb/flutter_native_progress_indicator/raw/refs/heads/main/native_indicators_recording.webp)



# Why

Flutter animation can be blocking, which can result in poor performance in some cases. For example when reading large data sets from the firestore cache.


# Usage

```
NativeCircularProgressIndicator() // instead of CircularProgressIndicator()

// or

NativeLinearProgressIndicator() // instead of LinearProgressIndicator()
```

On android you may have to change your theme to a material3 compatible theme. For example change `styles.xml` to:

```
<style name="Theme.MyApp" parent="Theme.Material3.DayNight.NoActionBar">
    <!-- ... -->
</style>
```

You can find detailed information here: https://github.com/material-components/material-components-android/blob/master/docs/getting-started.md#7-material3-theme-inheritance