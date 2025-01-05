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