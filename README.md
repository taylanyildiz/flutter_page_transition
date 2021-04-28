# flutter_page_transition

A new Flutter project.


## How To Use


```dart
   PageTransitionController? _controller;

    @override
    void initState() {
        super.initState();
        _controller = PageTransitionController(
        initalizePage: 0,
        onTranstionChanged: (animation) => {},
        );
    }
```


```dart
    PageTransitonView(
        controller: _controller,
        direction: Axis.horizontal,
        pages: _screens,
    ),
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
