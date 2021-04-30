# flutter_page_transition

A new Flutter project.
###
![Overview](https://user-images.githubusercontent.com/37551474/116740689-07a56800-a9fe-11eb-9459-8a6aad863747.gif)



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

### Doc.

```dart
/// For now it's just a repositionable [Widget], but more will come soon.
/// Imagine pageview but you can choose the animation you want. By keeping 
/// it very simple to use, the user will have a [Widget] that is far from all details.
/// Featuring animated transitions, page design and a control class, this widget will
/// give you a lot of possibilities.[PageTransitionController]
/// alignment is entirely at the user's discretion. [Axis] horizontal or vertical 
///
/// See also
/// 
/// 
/// *[Alignment] direction ([Offset.dx], [Offset.dy])
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
