# native_progress_indicator

Flutter progress indicators animation can be blocking and have negative impacts on performance.

This library replaces flutter `CircularProgressIndicator` and `LinearProgressIndicator` with a platform view implementation.


# Demo:

https://github.com/user-attachments/assets/ec32195f-752a-486e-8345-0c6ab17442f6


# Why

Flutter animation can be blocking, which can result in poor performance in some cases. For example when reading large data sets from the firestore cache.

Here is a flutter loading indicator running on a razer blade 2019 (unplugged) on the web.

![Screenshot 2025-01-04 at 17 39 05](https://github.com/user-attachments/assets/b2049fcf-0f22-47f7-a5c0-f18f159d56ce)
