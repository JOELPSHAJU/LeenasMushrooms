/*for calculating the correct measurement based on design*/
import 'dart:async';
import 'dart:collection';
import 'dart:math' show min, max;
import 'dart:ui' as ui show FlutterView;

import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenType {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 600 &&
      MediaQuery.of(context).size.shortestSide < 1024;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}

double commonResSizeForWeb(
    {required BuildContext context, required double mob, required double tab}) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;
  if (shortestSide <= 600) {
    return screenUtil(context, mob);
  } else {
    return screenUtil(context, tab);
  }
}

double commonResSizeForMob(
    {required BuildContext context, required double mob, required double tab}) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;
  if (shortestSide <= 600) {
    return mob;
  } else {
    return tab;
  }
}

/*for calculating web design*/
double screenUtil(BuildContext context, double measurement,
    [double? designValue]) {
  double web = 1920;
  double tab = 1024;
  double mob = 600;
  final double width = MediaQuery.sizeOf(context).width;
  if (width <= 600) {
    designValue = mob;
  } else if (width > 600 && width <= 1024) {
    designValue = tab;
  } else {
    designValue = web;
  }
  double value = measurement / (designValue);
  return MediaQuery.sizeOf(context).width * value;
}

/*for calculating mob design*/
mixin SU on Widget {}

typedef FontSizeResolver = double Function(
    num fontSize, ScreenUtilMob instance);

class ScreenUtilMob {
  static const Size defaultSize = Size(360, 690);
  static final ScreenUtilMob _instance = ScreenUtilMob._();

  static bool Function() _enableScaleWH = () => true;
  static bool Function() _enableScaleText = () => true;

  /// UI设计中手机尺寸 , dp
  /// Size of the phone in UI Design , dp
  late Size _uiSize;

  ///屏幕方向
  late Orientation _orientation;

  late bool _minTextAdapt;
  late MediaQueryData _data;
  late bool _splitScreenMode;
  FontSizeResolver? fontSizeResolver;

  ScreenUtilMob._();

  factory ScreenUtilMob() => _instance;

  /// Enable scale
  ///
  /// if the enableWH return false, the width and the height scale ratio will be 1
  /// if the enableText return false, the text scale ratio will be 1
  ///
  static void enableScale(
      {bool Function()? enableWH, bool Function()? enableText}) {
    _enableScaleWH = enableWH ?? () => true;
    _enableScaleText = enableText ?? () => true;
  }

  /// Manually wait for window size to be initialized
  ///
  /// `Recommended` to use before you need access window size
  /// or in custom splash/bootstrap screen [FutureBuilder]
  ///
  /// example:
  /// ```dart
  /// ...
  /// ScreenUtil.init(context, ...);
  /// ...
  ///   FutureBuilder(
  ///     future: Future.wait([..., ensureScreenSize(), ...]),
  ///     builder: (context, snapshot) {
  ///       if (snapshot.hasData) return const HomeScreen();
  ///       return Material(
  ///         child: LayoutBuilder(
  ///           ...
  ///         ),
  ///       );
  ///     },
  ///   )
  /// ```
  static Future<void> ensureScreenSize([
    ui.FlutterView? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    await Future.doWhile(() {
      window ??= binding.platformDispatcher.implicitView;

      if (window == null || window!.physicalSize.isEmpty) {
        return Future.delayed(duration, () => true);
      }

      return false;
    });

    binding.allowFirstFrame();
  }

  Set<Element>? _elementsToRebuild;

  /// ### Experimental
  /// Register current page and all its descendants to rebuild.
  /// Helpful when building for web and desktop
  static void registerToBuild(
    BuildContext context, [
    bool withDescendants = false,
  ]) {
    (_instance._elementsToRebuild ??= {}).add(context as Element);

    if (withDescendants) {
      context.visitChildren((element) {
        registerToBuild(element, true);
      });
    }
  }

  static void configure({
    MediaQueryData? data,
    Size? designSize,
    bool? splitScreenMode,
    bool? minTextAdapt,
    FontSizeResolver? fontSizeResolver,
  }) {
    try {
      if (data != null) {
        _instance._data = data;
      } else {
        data = _instance._data;
      }

      if (designSize != null) {
        _instance._uiSize = designSize;
      } else {
        designSize = _instance._uiSize;
      }
    } catch (_) {
      throw Exception(
          'You must either use ScreenUtil.init or ScreenUtilInit first');
    }

    final MediaQueryData? deviceData = data.nonEmptySizeOrNull();
    final Size deviceSize = deviceData?.size ?? designSize;

    final orientation = deviceData?.orientation ??
        (deviceSize.width > deviceSize.height
            ? Orientation.landscape
            : Orientation.portrait);

    _instance
      ..fontSizeResolver = fontSizeResolver ?? _instance.fontSizeResolver
      .._minTextAdapt = minTextAdapt ?? _instance._minTextAdapt
      .._splitScreenMode = splitScreenMode ?? _instance._splitScreenMode
      .._orientation = orientation;

    _instance._elementsToRebuild?.forEach((el) => el.markNeedsBuild());
  }

  /// Initializing the library.
  static void init(
    BuildContext context, {
    Size designSize = defaultSize,
    bool splitScreenMode = false,
    bool minTextAdapt = false,
    FontSizeResolver? fontSizeResolver,
  }) {
    final view = View.maybeOf(context);
    return configure(
      data: view != null ? MediaQueryData.fromView(view) : null,
      designSize: designSize,
      splitScreenMode: splitScreenMode,
      minTextAdapt: minTextAdapt,
      fontSizeResolver: fontSizeResolver,
    );
  }

  static Future<void> ensureScreenSizeAndInit(
    BuildContext context, {
    Size designSize = defaultSize,
    bool splitScreenMode = false,
    bool minTextAdapt = false,
    FontSizeResolver? fontSizeResolver,
  }) {
    return ScreenUtilMob.ensureScreenSize().then((_) {
      return init(
        context,
        designSize: designSize,
        minTextAdapt: minTextAdapt,
        splitScreenMode: splitScreenMode,
        fontSizeResolver: fontSizeResolver,
      );
    });
  }

  ///获取屏幕方向
  ///Get screen orientation
  Orientation get orientation => _orientation;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  double? get pixelRatio => _data.devicePixelRatio;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  double get screenWidth => _data.size.width;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  double get screenHeight => _data.size.height;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top, in dp
  double get statusBarHeight => _data.padding.top;

  /// 底部安全区距离 dp
  /// The offset from the bottom, in dp
  double get bottomBarHeight => _data.padding.bottom;

  /// 实际尺寸与UI设计的比例
  /// The ratio of actual width to UI design
  double get scaleWidth => !_enableScaleWH() ? 1 : screenWidth / _uiSize.width;

  /// The ratio of actual height to UI design
  double get scaleHeight => !_enableScaleWH()
      ? 1
      : (_splitScreenMode ? max(screenHeight, 700) : screenHeight) /
          _uiSize.height;

  double get scaleText => !_enableScaleText()
      ? 1
      : (_minTextAdapt ? min(scaleWidth, scaleHeight) : scaleWidth);

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你想要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///根据宽度或高度中的较小值进行适配
  ///Adapt according to the smaller of width or height
  double radius(num r) => r * min(scaleWidth, scaleHeight);

  /// Adapt according to the both width and height
  double diagonal(num d) => d * scaleHeight * scaleWidth;

  /// Adapt according to the maximum value of scale width and scale height
  double diameter(num d) => d * max(scaleWidth, scaleHeight);

  ///字体大小适配方法
  ///- [fontSize] UI设计上字体的大小,单位dp.
  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  double setSp(num fontSize) =>
      fontSizeResolver?.call(fontSize, _instance) ?? fontSize * scaleText;

  DeviceType deviceType(BuildContext context) {
    var deviceType = DeviceType.web;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    if (kIsWeb) {
      deviceType = DeviceType.web;
    } else {
      bool isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android;
      bool isTablet =
          (orientation == Orientation.portrait && screenWidth >= 600) ||
              (orientation == Orientation.landscape && screenHeight >= 600);

      if (isMobile) {
        deviceType = isTablet ? DeviceType.tablet : DeviceType.mobile;
      } else {
        switch (defaultTargetPlatform) {
          case TargetPlatform.linux:
            deviceType = DeviceType.linux;
            break;
          case TargetPlatform.macOS:
            deviceType = DeviceType.mac;
            break;
          case TargetPlatform.windows:
            deviceType = DeviceType.windows;
            break;
          case TargetPlatform.fuchsia:
            deviceType = DeviceType.fuchsia;
            break;
          default:
            break;
        }
      }
    }

    return deviceType;
  }

  SizedBox setVerticalSpacing(num height) =>
      SizedBox(height: setHeight(height));

  SizedBox setVerticalSpacingFromWidth(num height) =>
      SizedBox(height: setWidth(height));

  SizedBox setHorizontalSpacing(num width) => SizedBox(width: setWidth(width));

  SizedBox setHorizontalSpacingRadius(num width) =>
      SizedBox(width: radius(width));

  SizedBox setVerticalSpacingRadius(num height) =>
      SizedBox(height: radius(height));

  SizedBox setHorizontalSpacingDiameter(num width) =>
      SizedBox(width: diameter(width));

  SizedBox setVerticalSpacingDiameter(num height) =>
      SizedBox(height: diameter(height));

  SizedBox setHorizontalSpacingDiagonal(num width) =>
      SizedBox(width: diagonal(width));

  SizedBox setVerticalSpacingDiagonal(num height) =>
      SizedBox(height: diagonal(height));
}

extension on MediaQueryData? {
  MediaQueryData? nonEmptySizeOrNull() {
    if (this?.size.isEmpty ?? true) {
      return null;
    } else {
      return this;
    }
  }
}

enum DeviceType { mobile, tablet, web, mac, windows, linux, fuchsia }

typedef RebuildFactor = bool Function(MediaQueryData old, MediaQueryData data);
typedef ScreenUtilInitBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

abstract class RebuildFactors {
  static bool size(MediaQueryData old, MediaQueryData data) {
    return old.size != data.size;
  }

  static bool orientation(MediaQueryData old, MediaQueryData data) {
    return old.orientation != data.orientation;
  }

  static bool sizeAndViewInsets(MediaQueryData old, MediaQueryData data) {
    return old.viewInsets != data.viewInsets;
  }

  static bool change(MediaQueryData old, MediaQueryData data) {
    return old != data;
  }

  static bool always(MediaQueryData _, MediaQueryData __) {
    return true;
  }

  static bool none(MediaQueryData _, MediaQueryData __) {
    return false;
  }
}

abstract class FontSizeResolvers {
  static double width(num fontSize, ScreenUtilMob instance) {
    return instance.setWidth(fontSize);
  }

  static double height(num fontSize, ScreenUtilMob instance) {
    return instance.setHeight(fontSize);
  }

  static double radius(num fontSize, ScreenUtilMob instance) {
    return instance.radius(fontSize);
  }

  static double diameter(num fontSize, ScreenUtilMob instance) {
    return instance.diameter(fontSize);
  }

  static double diagonal(num fontSize, ScreenUtilMob instance) {
    return instance.diagonal(fontSize);
  }
}

class ScreenUtilInit extends StatefulWidget {
  /// A helper widget that initializes [ScreenUtil]
  const ScreenUtilInit({
    super.key,
    this.builder,
    this.child,
    this.rebuildFactor = RebuildFactors.size,
    this.designSize = ScreenUtilMob.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    this.useInheritedMediaQuery = false,
    this.ensureScreenSize = false,
    this.enableScaleWH,
    this.enableScaleText,
    this.responsiveWidgets,
    this.excludeWidgets,
    this.fontSizeResolver = FontSizeResolvers.width,
  });

  final ScreenUtilInitBuilder? builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;
  final bool useInheritedMediaQuery;
  final bool ensureScreenSize;
  final bool Function()? enableScaleWH;
  final bool Function()? enableScaleText;
  final RebuildFactor rebuildFactor;
  final FontSizeResolver fontSizeResolver;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;
  final Iterable<String>? responsiveWidgets;
  final Iterable<String>? excludeWidgets;

  @override
  State<ScreenUtilInit> createState() => _ScreenUtilInitState();
}

class _ScreenUtilInitState extends State<ScreenUtilInit>
    with WidgetsBindingObserver {
  final _canMarkedToBuild = HashSet<String>();
  final _excludedWidgets = HashSet<String>();
  MediaQueryData? _mediaQueryData;
  final _binding = WidgetsBinding.instance;
  final _screenSizeCompleter = Completer<void>();

  @override
  void initState() {
    if (widget.responsiveWidgets != null) {
      _canMarkedToBuild.addAll(widget.responsiveWidgets!);
    }

    ScreenUtilMob.enableScale(
        enableWH: widget.enableScaleWH, enableText: widget.enableScaleText);

    _validateSize().then(_screenSizeCompleter.complete);

    super.initState();
    _binding.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _revalidate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _revalidate();
  }

  MediaQueryData? _newData() {
    final view = View.maybeOf(context);
    if (view != null) return MediaQueryData.fromView(view);
    return null;
  }

  Future<void> _validateSize() async {
    if (widget.ensureScreenSize) return ScreenUtilMob.ensureScreenSize();
  }

  void _markNeedsBuildIfAllowed(Element el) {
    final widgetName = el.widget.runtimeType.toString();
    if (_excludedWidgets.contains(widgetName)) return;
    final allowed = widget is SU ||
        _canMarkedToBuild.contains(widgetName) ||
        !(widgetName.startsWith('_') || flutterWidgets.contains(widgetName));

    if (allowed) el.markNeedsBuild();
  }

  void _updateTree(Element el) {
    _markNeedsBuildIfAllowed(el);
    el.visitChildren(_updateTree);
  }

  void _revalidate([void Function()? callback]) {
    final oldData = _mediaQueryData;
    final newData = _newData();

    if (newData == null) return;

    if (oldData == null || widget.rebuildFactor(oldData, newData)) {
      setState(() {
        _mediaQueryData = newData;
        _updateTree(context as Element);
        callback?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = _mediaQueryData;

    if (mq == null) return const SizedBox.shrink();

    if (!widget.ensureScreenSize) {
      ScreenUtilMob.configure(
        data: mq,
        designSize: widget.designSize,
        splitScreenMode: widget.splitScreenMode,
        minTextAdapt: widget.minTextAdapt,
        fontSizeResolver: widget.fontSizeResolver,
      );

      return widget.builder?.call(context, widget.child) ?? widget.child!;
    }

    return FutureBuilder<void>(
      future: _screenSizeCompleter.future,
      builder: (c, snapshot) {
        ScreenUtilMob.configure(
          data: mq,
          designSize: widget.designSize,
          splitScreenMode: widget.splitScreenMode,
          minTextAdapt: widget.minTextAdapt,
          fontSizeResolver: widget.fontSizeResolver,
        );

        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder?.call(context, widget.child) ?? widget.child!;
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _binding.removeObserver(this);
    super.dispose();
  }
}

final flutterWidgets = HashSet<String>.from({
  'AbsorbPointer',
  'Accumulator',
  'Action',
  'ActionDispatcher',
  'ActionListener',
  'Actions',
  'ActivateAction',
  'ActivateIntent',
  'Align',
  'Alignment',
  'AlignmentDirectional',
  'AlignmentGeometry',
  'AlignmentGeometryTween',
  'AlignmentTween',
  'AlignTransition',
  'AlwaysScrollableScrollPhysics',
  'AlwaysStoppedAnimation',
  'AndroidView',
  'AndroidViewSurface',
  'Animatable',
  'AnimatedAlign',
  'AnimatedBuilder',
  'AnimatedContainer',
  'AnimatedCrossFade',
  'AnimatedDefaultTextStyle',
  'AnimatedFractionallySizedBox',
  'AnimatedGrid',
  'AnimatedGridState',
  'AnimatedList',
  'AnimatedListState',
  'AnimatedModalBarrier',
  'AnimatedOpacity',
  'AnimatedPadding',
  'AnimatedPhysicalModel',
  'AnimatedPositioned',
  'AnimatedPositionedDirectional',
  'AnimatedRotation',
  'AnimatedScale',
  'AnimatedSize',
  'AnimatedSlide',
  'AnimatedSwitcher',
  'AnimatedWidget',
  'AnimatedWidgetBaseState',
  'Animation',
  'AnimationController',
  'AnimationMax',
  'AnimationMean',
  'AnimationMin',
  'AnnotatedRegion',
  'AspectRatio',
  'AssetBundle',
  'AssetBundleImageKey',
  'AssetBundleImageProvider',
  'AssetImage',
  'AsyncSnapshot',
  'AutocompleteHighlightedOption',
  'AutocompleteNextOptionIntent',
  'AutocompletePreviousOptionIntent',
  'AutofillGroup',
  'AutofillGroupState',
  'AutofillHints',
  'AutomaticKeepAlive',
  'AutomaticNotchedShape',
  'BackButtonDispatcher',
  'BackButtonListener',
  'BackdropFilter',
  'BallisticScrollActivity',
  'Banner',
  'BannerPainter',
  'Baseline',
  'BaseTapAndDragGestureRecognizer',
  'BeveledRectangleBorder',
  'BlockSemantics',
  'Border',
  'BorderDirectional',
  'BorderRadius',
  'BorderRadiusDirectional',
  'BorderRadiusGeometry',
  'BorderRadiusTween',
  'BorderSide',
  'BorderTween',
  'BottomNavigationBarItem',
  'BouncingScrollPhysics',
  'BouncingScrollSimulation',
  'BoxBorder',
  'BoxConstraints',
  'BoxConstraintsTween',
  'BoxDecoration',
  'BoxPainter',
  'BoxScrollView',
  'BoxShadow',
  'BuildContext',
  'Builder',
  'BuildOwner',
  'ButtonActivateIntent',
  'CallbackAction',
  'CallbackShortcuts',
  'Canvas',
  'CapturedThemes',
  'CatmullRomCurve',
  'CatmullRomSpline',
  'Center',
  'ChangeNotifier',
  'CharacterActivator',
  'CharacterRange',
  'Characters',
  'CheckedModeBanner',
  'ChildBackButtonDispatcher',
  'CircleBorder',
  'CircularNotchedRectangle',
  'ClampingScrollPhysics',
  'ClampingScrollSimulation',
  'ClipboardStatusNotifier',
  'ClipContext',
  'ClipOval',
  'ClipPath',
  'ClipRect',
  'ClipRRect',
  'Color',
  'ColoredBox',
  'ColorFilter',
  'ColorFiltered',
  'ColorProperty',
  'ColorSwatch',
  'ColorTween',
  'Column',
  'ComponentElement',
  'CompositedTransformFollower',
  'CompositedTransformTarget',
  'CompoundAnimation',
  'ConstantTween',
  'ConstrainedBox',
  'ConstrainedLayoutBuilder',
  'ConstraintsTransformBox',
  'Container',
  'ContentInsertionConfiguration',
  'ContextAction',
  'ContextMenuButtonItem',
  'ContextMenuController',
  'ContinuousRectangleBorder',
  'CopySelectionTextIntent',
  'Cubic',
  'Curve',
  'Curve2D',
  'Curve2DSample',
  'CurvedAnimation',
  'Curves',
  'CurveTween',
  'CustomClipper',
  'CustomMultiChildLayout',
  'CustomPaint',
  'CustomPainter',
  'CustomPainterSemantics',
  'CustomScrollView',
  'CustomSingleChildLayout',
  'DebugCreator',
  'DecoratedBox',
  'DecoratedBoxTransition',
  'Decoration',
  'DecorationImage',
  'DecorationImagePainter',
  'DecorationTween',
  'DefaultAssetBundle',
  'DefaultPlatformMenuDelegate',
  'DefaultSelectionStyle',
  'DefaultTextEditingShortcuts',
  'DefaultTextHeightBehavior',
  'DefaultTextStyle',
  'DefaultTextStyleTransition',
  'DefaultTransitionDelegate',
  'DefaultWidgetsLocalizations',
  'DeleteCharacterIntent',
  'DeleteToLineBreakIntent',
  'DeleteToNextWordBoundaryIntent',
  'DesktopTextSelectionToolbarLayoutDelegate',
  'DevToolsDeepLinkProperty',
  'DiagnosticsNode',
  'DirectionalCaretMovementIntent',
  'DirectionalFocusAction',
  'DirectionalFocusIntent',
  'Directionality',
  'DirectionalTextEditingIntent',
  'DismissAction',
  'Dismissible',
  'DismissIntent',
  'DismissUpdateDetails',
  'DisplayFeatureSubScreen',
  'DisposableBuildContext',
  'DoNothingAction',
  'DoNothingAndStopPropagationIntent',
  'DoNothingAndStopPropagationTextIntent',
  'DoNothingIntent',
  'DragDownDetails',
  'DragEndDetails',
  'Draggable',
  'DraggableDetails',
  'DraggableScrollableActuator',
  'DraggableScrollableController',
  'DraggableScrollableNotification',
  'DraggableScrollableSheet',
  'DragScrollActivity',
  'DragStartDetails',
  'DragTarget',
  'DragTargetDetails',
  'DragUpdateDetails',
  'DrivenScrollActivity',
  'DualTransitionBuilder',
  'EdgeDraggingAutoScroller',
  'EdgeInsetsDirectional',
  'EdgeInsetsDirectionalDirectional',
  'EdgeInsetsDirectionalGeometry',
  'EdgeInsetsDirectionalGeometryTween',
  'EdgeInsetsDirectionalTween',
  'EditableText',
  'EditableTextState',
  'ElasticInCurve',
  'ElasticInOutCurve',
  'ElasticOutCurve',
  'Element',
  'EmptyTextSelectionControls',
  'ErrorDescription',
  'ErrorHint',
  'ErrorSummary',
  'ErrorWidget',
  'ExactAssetImage',
  'ExcludeFocus',
  'ExcludeFocusTraversal',
  'ExcludeSemantics',
  'Expanded',
  'ExpandSelectionToDocumentBoundaryIntent',
  'ExpandSelectionToLineBreakIntent',
  'ExtendSelectionByCharacterIntent',
  'ExtendSelectionByPageIntent',
  'ExtendSelectionToDocumentBoundaryIntent',
  'ExtendSelectionToLineBreakIntent',
  'ExtendSelectionToNextParagraphBoundaryIntent',
  'ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent',
  'ExtendSelectionToNextWordBoundaryIntent',
  'ExtendSelectionToNextWordBoundaryOrCaretLocationIntent',
  'ExtendSelectionVerticallyToAdjacentLineIntent',
  'ExtendSelectionVerticallyToAdjacentPageIntent',
  'FadeInImage',
  'FadeTransition',
  'FileImage',
  'FittedBox',
  'FittedSizes',
  'FixedColumnWidth',
  'FixedExtentMetrics',
  'FixedExtentScrollController',
  'FixedExtentScrollPhysics',
  'FixedScrollMetrics',
  'Flex',
  'FlexColumnWidth',
  'Flexible',
  'FlippedCurve',
  'FlippedTweenSequence',
  'Flow',
  'FlowDelegate',
  'FlowPaintingContext',
  'FlutterErrorDetails',
  'FlutterLogoDecoration',
  'Focus',
  'FocusableActionDetector',
  'FocusAttachment',
  'FocusManager',
  'FocusNode',
  'FocusOrder',
  'FocusScope',
  'FocusScopeNode',
  'FocusTraversalGroup',
  'FocusTraversalOrder',
  'FocusTraversalPolicy',
  'FontWeight',
  'ForcePressDetails',
  'Form',
  'FormField',
  'FormFieldState',
  'FormState',
  'FractionallySizedBox',
  'FractionalOffset',
  'FractionalOffsetTween',
  'FractionalTranslation',
  'FractionColumnWidth',
  'FutureBuilder',
  'GestureDetector',
  'GestureRecognizerFactory',
  'GestureRecognizerFactoryWithHandlers',
  'GlobalKey',
  'GlobalObjectKey',
  'GlowingOverscrollIndicator',
  'Gradient',
  'GradientRotation',
  'GradientTransform',
  'GridPaper',
  'GridView',
  'Hero',
  'HeroController',
  'HeroControllerScope',
  'HeroMode',
  'HoldScrollActivity',
  'HSLColor',
  'HSVColor',
  'HtmlElementView',
  'Icon',
  'IconData',
  'IconDataProperty',
  'IconTheme',
  'IconThemeData',
  'IdleScrollActivity',
  'IgnorePointer',
  'Image',
  'ImageCache',
  'ImageCacheStatus',
  'ImageChunkEvent',
  'ImageConfiguration',
  'ImageFiltered',
  'ImageIcon',
  'ImageInfo',
  'ImageProvider',
  'ImageShader',
  'ImageSizeInfo',
  'ImageStream',
  'ImageStreamCompleter',
  'ImageStreamCompleterHandle',
  'ImageStreamListener',
  'ImageTilingInfo',
  'ImplicitlyAnimatedWidget',
  'ImplicitlyAnimatedWidgetState',
  'IndexedSemantics',
  'IndexedSlot',
  'IndexedStack',
  'InheritedElement',
  'InheritedModel',
  'InheritedModelElement',
  'InheritedNotifier',
  'InheritedTheme',
  'InheritedWidget',
  'InlineSpan',
  'InlineSpanSemanticsInformation',
  'InspectorSelection',
  'InspectorSerializationDelegate',
  'Intent',
  'InteractiveViewer',
  'Interval',
  'IntrinsicColumnWidth',
  'IntrinsicHeight',
  'IntrinsicWidth',
  'IntTween',
  'KeepAlive',
  'KeepAliveHandle',
  'KeepAliveNotification',
  'Key',
  'KeyboardInsertedContent',
  'KeyboardListener',
  'KeyedSubtree',
  'KeyEvent',
  'KeySet',
  'LabeledGlobalKey',
  'LayerLink',
  'LayoutBuilder',
  'LayoutChangedNotification',
  'LayoutId',
  'LeafRenderObjectElement',
  'LeafRenderObjectWidget',
  'LexicalFocusOrder',
  'LimitedBox',
  'LinearBorder',
  'LinearBorderEdge',
  'LinearGradient',
  'ListBody',
  'Listenable',
  'ListenableBuilder',
  'Listener',
  'ListView',
  'ListWheelChildBuilderDelegate',
  'ListWheelChildDelegate',
  'ListWheelChildListDelegate',
  'ListWheelChildLoopingListDelegate',
  'ListWheelElement',
  'ListWheelScrollView',
  'ListWheelViewport',
  'Locale',
  'LocalHistoryEntry',
  'Localizations',
  'LocalizationsDelegate',
  'LocalKey',
  'LogicalKeySet',
  'LongPressDraggable',
  'LongPressEndDetails',
  'LongPressMoveUpdateDetails',
  'LongPressStartDetails',
  'LookupBoundary',
  'MagnifierController',
  'MagnifierDecoration',
  'MagnifierInfo',
  'MaskFilter',
  'Matrix4',
  'Matrix4Tween',
  'MatrixUtils',
  'MaxColumnWidth',
  'MediaQuery',
  'MediaQueryData',
  'MemoryImage',
  'MergeSemantics',
  'MetaData',
  'MinColumnWidth',
  'ModalBarrier',
  'ModalRoute',
  'MouseCursor',
  'MouseRegion',
  'MultiChildLayoutDelegate',
  'MultiChildRenderObjectElement',
  'MultiChildRenderObjectWidget',
  'MultiFrameImageStreamCompleter',
  'MultiSelectableSelectionContainerDelegate',
  'NavigationToolbar',
  'Navigator',
  'NavigatorObserver',
  'NavigatorState',
  'NestedScrollView',
  'NestedScrollViewState',
  'NestedScrollViewViewport',
  'NetworkImage',
  'NeverScrollableScrollPhysics',
  'NextFocusAction',
  'NextFocusIntent',
  'NotchedShape',
  'Notification',
  'NotificationListener',
  'NumericFocusOrder',
  'ObjectKey',
  'Offset',
  'Offstage',
  'OneFrameImageStreamCompleter',
  'Opacity',
  'OrderedTraversalPolicy',
  'OrientationBuilder',
  'OutlinedBorder',
  'OvalBorder',
  'OverflowBar',
  'OverflowBox',
  'Overlay',
  'OverlayEntry',
  'OverlayPortal',
  'OverlayPortalController',
  'OverlayRoute',
  'OverlayState',
  'OverscrollIndicatorNotification',
  'OverscrollNotification',
  'Padding',
  'Page',
  'PageController',
  'PageMetrics',
  'PageRoute',
  'PageRouteBuilder',
  'PageScrollPhysics',
  'PageStorage',
  'PageStorageBucket',
  'PageStorageKey',
  'PageView',
  'Paint',
  'PaintingContext',
  'ParametricCurve',
  'ParentDataElement',
  'ParentDataWidget',
  'PasteTextIntent',
  'Path',
  'PerformanceOverlay',
  'PhysicalModel',
  'PhysicalShape',
  'Placeholder',
  'PlaceholderDimensions',
  'PlaceholderSpan',
  'PlatformMenu',
  'PlatformMenuBar',
  'PlatformMenuDelegate',
  'PlatformMenuItem',
  'PlatformMenuItemGroup',
  'PlatformProvidedMenuItem',
  'PlatformRouteInformationProvider',
  'PlatformSelectableRegionContextMenu',
  'PlatformViewCreationParams',
  'PlatformViewLink',
  'PlatformViewSurface',
  'PointerCancelEvent',
  'PointerDownEvent',
  'PointerEvent',
  'PointerMoveEvent',
  'PointerUpEvent',
  'PopupRoute',
  'Positioned',
  'PositionedDirectional',
  'PositionedTransition',
  'PreferredSize',
  'PreferredSizeWidget',
  'PreviousFocusAction',
  'PreviousFocusIntent',
  'PrimaryScrollController',
  'PrioritizedAction',
  'PrioritizedIntents',
  'ProxyAnimation',
  'ProxyElement',
  'ProxyWidget',
  'RadialGradient',
  'Radius',
  'RangeMaintainingScrollPhysics',
  'RawAutocomplete',
  'RawDialogRoute',
  'RawGestureDetector',
  'RawGestureDetectorState',
  'RawImage',
  'RawKeyboardListener',
  'RawKeyEvent',
  'RawMagnifier',
  'RawScrollbar',
  'RawScrollbarState',
  'ReadingOrderTraversalPolicy',
  'Rect',
  'RectTween',
  'RedoTextIntent',
  'RelativePositionedTransition',
  'RelativeRect',
  'RelativeRectTween',
  'RenderBox',
  'RenderNestedScrollViewViewport',
  'RenderObject',
  'RenderObjectElement',
  'RenderObjectToWidgetAdapter',
  'RenderObjectToWidgetElement',
  'RenderObjectWidget',
  'RenderSemanticsGestureHandler',
  'RenderSliverOverlapAbsorber',
  'RenderSliverOverlapInjector',
  'RenderTapRegion',
  'RenderTapRegionSurface',
  'ReorderableDelayedDragStartListener',
  'ReorderableDragStartListener',
  'ReorderableList',
  'ReorderableListState',
  'RepaintBoundary',
  'ReplaceTextIntent',
  'RequestFocusAction',
  'RequestFocusIntent',
  'ResizeImage',
  'ResizeImageKey',
  'RestorableBool',
  'RestorableBoolN',
  'RestorableChangeNotifier',
  'RestorableDateTime',
  'RestorableDateTimeN',
  'RestorableDouble',
  'RestorableDoubleN',
  'RestorableEnum',
  'RestorableEnumN',
  'RestorableInt',
  'RestorableIntN',
  'RestorableListenable',
  'RestorableNum',
  'RestorableNumN',
  'RestorableProperty',
  'RestorableRouteFuture',
  'RestorableString',
  'RestorableStringN',
  'RestorableTextEditingController',
  'RestorableValue',
  'RestorationBucket',
  'RestorationScope',
  'ReverseAnimation',
  'ReverseTween',
  'RichText',
  'RootBackButtonDispatcher',
  'RootRenderObjectElement',
  'RootRestorationScope',
  'RotatedBox',
  'RotationTransition',
  'RoundedRectangleBorder',
  'Route',
  'RouteAware',
  'RouteInformation',
  'RouteInformationParser',
  'RouteInformationProvider',
  'RouteObserver',
  'Router',
  'RouterConfig',
  'RouterDelegate',
  'RouteSettings',
  'RouteTransitionRecord',
  'Row',
  'RRect',
  'RSTransform',
  'SafeArea',
  'SawTooth',
  'ScaleEndDetails',
  'ScaleStartDetails',
  'ScaleTransition',
  'ScaleUpdateDetails',
  'Scrollable',
  'ScrollableDetails',
  'ScrollableState',
  'ScrollAction',
  'ScrollActivity',
  'ScrollActivityDelegate',
  'ScrollAwareImageProvider',
  'ScrollbarPainter',
  'ScrollBehavior',
  'ScrollConfiguration',
  'ScrollContext',
  'ScrollController',
  'ScrollDragController',
  'ScrollEndNotification',
  'ScrollHoldController',
  'ScrollIncrementDetails',
  'ScrollIntent',
  'ScrollMetricsNotification',
  'ScrollNotification',
  'ScrollNotificationObserver',
  'ScrollNotificationObserverState',
  'ScrollPhysics',
  'ScrollPosition',
  'ScrollPositionWithSingleContext',
  'ScrollSpringSimulation',
  'ScrollStartNotification',
  'ScrollToDocumentBoundaryIntent',
  'ScrollUpdateNotification',
  'ScrollView',
  'SelectableRegion',
  'SelectableRegionState',
  'SelectAction',
  'SelectAllTextIntent',
  'SelectIntent',
  'SelectionContainer',
  'SelectionContainerDelegate',
  'SelectionOverlay',
  'SelectionRegistrarScope',
  'Semantics',
  'SemanticsDebugger',
  'SemanticsGestureDelegate',
  'Shader',
  'ShaderMask',
  'ShaderWarmUp',
  'Shadow',
  'ShapeBorder',
  'ShapeBorderClipper',
  'ShapeDecoration',
  'SharedAppData',
  'ShortcutActivator',
  'ShortcutManager',
  'ShortcutMapProperty',
  'ShortcutRegistrar',
  'ShortcutRegistry',
  'ShortcutRegistryEntry',
  'Shortcuts',
  'ShortcutSerialization',
  'ShrinkWrappingViewport',
  'Simulation',
  'SingleActivator',
  'SingleChildLayoutDelegate',
  'SingleChildRenderObjectElement',
  'SingleChildRenderObjectWidget',
  'SingleChildScrollView',
  'Size',
  'SizeChangedLayoutNotification',
  'SizeChangedLayoutNotifier',
  'SizedBox',
  'SizedOverflowBox',
  'SizeTransition',
  'SizeTween',
  'SlideTransition',
  'SliverAnimatedGrid',
  'SliverAnimatedGridState',
  'SliverAnimatedList',
  'SliverAnimatedListState',
  'SliverAnimatedOpacity',
  'SliverChildBuilderDelegate',
  'SliverChildDelegate',
  'SliverChildListDelegate',
  'SliverFadeTransition',
  'SliverFillRemaining',
  'SliverFillViewport',
  'SliverFixedExtentList',
  'SliverGrid',
  'SliverGridDelegate',
  'SliverGridDelegateWithFixedCrossAxisCount',
  'SliverGridDelegateWithMaxCrossAxisExtent',
  'SliverIgnorePointer',
  'SliverLayoutBuilder',
  'SliverList',
  'SliverMultiBoxAdaptorElement',
  'SliverMultiBoxAdaptorWidget',
  'SliverOffstage',
  'SliverOpacity',
  'SliverOverlapAbsorber',
  'SliverOverlapAbsorberHandle',
  'SliverOverlapInjector',
  'SliverPadding',
  'SliverPersistentHeader',
  'SliverPersistentHeaderDelegate',
  'SliverPrototypeExtentList',
  'SliverReorderableList',
  'SliverReorderableListState',
  'SliverSafeArea',
  'SliverToBoxAdapter',
  'SliverVisibility',
  'SliverWithKeepAliveWidget',
  'SlottedRenderObjectElement',
  'SnapshotController',
  'SnapshotPainter',
  'SnapshotWidget',
  'Spacer',
  'SpellCheckConfiguration',
  'SpringDescription',
  'Stack',
  'StadiumBorder',
  'StarBorder',
  'State',
  'StatefulBuilder',
  'StatefulElement',
  'StatefulWidget',
  'StatelessElement',
  'StatelessWidget',
  'StatusTransitionWidget',
  'StepTween',
  'StreamBuilder',
  'StreamBuilderBase',
  'StretchingOverscrollIndicator',
  'StrutStyle',
  'SweepGradient',
  'SystemMouseCursors',
  'Table',
  'TableBorder',
  'TableCell',
  'TableColumnWidth',
  'TableRow',
  'TapAndDragGestureRecognizer',
  'TapAndHorizontalDragGestureRecognizer',
  'TapAndPanGestureRecognizer',
  'TapDownDetails',
  'TapDragDownDetails',
  'TapDragEndDetails',
  'TapDragStartDetails',
  'TapDragUpdateDetails',
  'TapDragUpDetails',
  'TapRegion',
  'TapRegionRegistry',
  'TapRegionSurface',
  'TapUpDetails',
  'Text',
  'TextAlignVertical',
  'TextBox',
  'TextDecoration',
  'TextEditingController',
  'TextEditingValue',
  'TextFieldTapRegion',
  'TextHeightBehavior',
  'TextInputType',
  'TextMagnifierConfiguration',
  'TextPainter',
  'TextPosition',
  'TextRange',
  'TextSelection',
  'TextSelectionControls',
  'TextSelectionGestureDetector',
  'TextSelectionGestureDetectorBuilder',
  'TextSelectionGestureDetectorBuilderDelegate',
  'TextSelectionOverlay',
  'TextSelectionPoint',
  'TextSelectionToolbarAnchors',
  'TextSelectionToolbarLayoutDelegate',
  'TextSpan',
  'TextStyle',
  'TextStyleTween',
  'Texture',
  'ThreePointCubic',
  'Threshold',
  'TickerFuture',
  'TickerMode',
  'TickerProvider',
  'Title',
  'Tolerance',
  'ToolbarItemsParentData',
  'ToolbarOptions',
  'TrackingScrollController',
  'TrainHoppingAnimation',
  'Transform',
  'TransformationController',
  'TransformProperty',
  'TransitionDelegate',
  'TransitionRoute',
  'TransposeCharactersIntent',
  'Tween',
  'TweenAnimationBuilder',
  'TweenSequence',
  'TweenSequenceItem',
  'UiKitView',
  'UnconstrainedBox',
  'UndoHistory',
  'UndoHistoryController',
  'UndoHistoryState',
  'UndoHistoryValue',
  'UndoTextIntent',
  'UniqueKey',
  'UniqueWidget',
  'UnmanagedRestorationScope',
  'UpdateSelectionIntent',
  'UserScrollNotification',
  'ValueKey',
  'ValueListenableBuilder',
  'ValueNotifier',
  'Velocity',
  'View',
  'Viewport',
  'Visibility',
  'VoidCallbackAction',
  'VoidCallbackIntent',
  'Widget',
  'WidgetInspector',
  'WidgetOrderTraversalPolicy',
  'WidgetsApp',
  'WidgetsBindingObserver',
  'WidgetsFlutterBinding',
  'WidgetsLocalizations',
  'WidgetSpan',
  'WidgetToRenderBoxAdapter',
  'WillPopScope',
  'WordBoundary',
  'Wrap'
});

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtilMob().setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtilMob().setHeight(this);

  ///[ScreenUtil.radius]
  double get r => ScreenUtilMob().radius(this);

  ///[ScreenUtil.diagonal]
  double get dg => ScreenUtilMob().diagonal(this);

  ///[ScreenUtil.diameter]
  double get dm => ScreenUtilMob().diameter(this);

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtilMob().setSp(this);

  ///smart size :  it check your value - if it is bigger than your value it will set your value
  ///for example, you have set 16.sm() , if for your screen 16.sp() is bigger than 16 , then it will set 16 not 16.sp()
  ///I think that it is good for save size balance on big sizes of screen
  double get spMin => min(toDouble(), sp);

  @Deprecated('use spMin instead')
  double get sm => min(toDouble(), sp);

  double get spMax => max(toDouble(), sp);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get sw => ScreenUtilMob().screenWidth * this;

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get sh => ScreenUtilMob().screenHeight * this;

  ///[ScreenUtil.setHeight]
  SizedBox get verticalSpace => ScreenUtilMob().setVerticalSpacing(this);

  ///[ScreenUtil.setVerticalSpacingFromWidth]
  SizedBox get verticalSpaceFromWidth =>
      ScreenUtilMob().setVerticalSpacingFromWidth(this);

  ///[ScreenUtil.setWidth]
  SizedBox get horizontalSpace => ScreenUtilMob().setHorizontalSpacing(this);

  ///[ScreenUtil.radius]
  SizedBox get horizontalSpaceRadius =>
      ScreenUtilMob().setHorizontalSpacingRadius(this);

  ///[ScreenUtil.radius]
  SizedBox get verticalSpacingRadius =>
      ScreenUtilMob().setVerticalSpacingRadius(this);

  ///[ScreenUtil.diameter]
  SizedBox get horizontalSpaceDiameter =>
      ScreenUtilMob().setHorizontalSpacingDiameter(this);

  ///[ScreenUtil.diameter]
  SizedBox get verticalSpacingDiameter =>
      ScreenUtilMob().setVerticalSpacingDiameter(this);

  ///[ScreenUtil.diagonal]
  SizedBox get horizontalSpaceDiagonal =>
      ScreenUtilMob().setHorizontalSpacingDiagonal(this);

  ///[ScreenUtil.diagonal]
  SizedBox get verticalSpacingDiagonal =>
      ScreenUtilMob().setVerticalSpacingDiagonal(this);
}

extension EdgeInsetsDirectionalExtension on EdgeInsetsDirectional {
  /// Creates adapt insets using r [SizeExtension].
  EdgeInsetsDirectional get r => copyWith(
        top: top.r,
        bottom: bottom.r,
        end: end.r,
        start: start.r,
      );

  EdgeInsetsDirectional get dm => copyWith(
        top: top.dm,
        bottom: bottom.dm,
        end: end.dm,
        start: start.dm,
      );

  EdgeInsetsDirectional get dg => copyWith(
        top: top.dg,
        bottom: bottom.dg,
        end: end.dg,
        start: start.dg,
      );

  EdgeInsetsDirectional get w => copyWith(
        top: top.w,
        bottom: bottom.w,
        end: end.w,
        start: start.w,
      );

  EdgeInsetsDirectional get h => copyWith(
        top: top.h,
        bottom: bottom.h,
        end: end.h,
        start: start.h,
      );
}

extension BorderRadiusExtension on BorderRadius {
  /// Creates adapt BorderRadius using r [SizeExtension].
  BorderRadius get r => copyWith(
        bottomLeft: bottomLeft.r,
        bottomRight: bottomRight.r,
        topLeft: topLeft.r,
        topRight: topRight.r,
      );

  BorderRadius get w => copyWith(
        bottomLeft: bottomLeft.w,
        bottomRight: bottomRight.w,
        topLeft: topLeft.w,
        topRight: topRight.w,
      );

  BorderRadius get h => copyWith(
        bottomLeft: bottomLeft.h,
        bottomRight: bottomRight.h,
        topLeft: topLeft.h,
        topRight: topRight.h,
      );
}

extension RadiusExtension on Radius {
  /// Creates adapt Radius using r [SizeExtension].
  Radius get r => Radius.elliptical(x.r, y.r);

  Radius get dm => Radius.elliptical(x.dm, y.dm);

  Radius get dg => Radius.elliptical(x.dg, y.dg);

  Radius get w => Radius.elliptical(x.w, y.w);

  Radius get h => Radius.elliptical(x.h, y.h);
}

extension BoxConstraintsExtension on BoxConstraints {
  /// Creates adapt BoxConstraints using r [SizeExtension].
  BoxConstraints get r => copyWith(
        maxHeight: maxHeight.r,
        maxWidth: maxWidth.r,
        minHeight: minHeight.r,
        minWidth: minWidth.r,
      );

  /// Creates adapt BoxConstraints using h-w [SizeExtension].
  BoxConstraints get hw => copyWith(
        maxHeight: maxHeight.h,
        maxWidth: maxWidth.w,
        minHeight: minHeight.h,
        minWidth: minWidth.w,
      );

  BoxConstraints get w => copyWith(
        maxHeight: maxHeight.w,
        maxWidth: maxWidth.w,
        minHeight: minHeight.w,
        minWidth: minWidth.w,
      );

  BoxConstraints get h => copyWith(
        maxHeight: maxHeight.h,
        maxWidth: maxWidth.h,
        minHeight: minHeight.h,
        minWidth: minWidth.h,
      );
}
