/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Manrope-Bold.ttf
  String get manropeBold => 'assets/fonts/Manrope-Bold.ttf';

  /// File path: assets/fonts/Manrope-ExtraBold.ttf
  String get manropeExtraBold => 'assets/fonts/Manrope-ExtraBold.ttf';

  /// File path: assets/fonts/Manrope-ExtraLight.ttf
  String get manropeExtraLight => 'assets/fonts/Manrope-ExtraLight.ttf';

  /// File path: assets/fonts/Manrope-Light.ttf
  String get manropeLight => 'assets/fonts/Manrope-Light.ttf';

  /// File path: assets/fonts/Manrope-Medium.ttf
  String get manropeMedium => 'assets/fonts/Manrope-Medium.ttf';

  /// File path: assets/fonts/Manrope-Regular.ttf
  String get manropeRegular => 'assets/fonts/Manrope-Regular.ttf';

  /// File path: assets/fonts/Manrope-SemiBold.ttf
  String get manropeSemiBold => 'assets/fonts/Manrope-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
        manropeBold,
        manropeExtraBold,
        manropeExtraLight,
        manropeLight,
        manropeMedium,
        manropeRegular,
        manropeSemiBold
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/images/chat.svg');

  /// File path: assets/images/forkandknife.svg
  SvgGenImage get forkandknife =>
      const SvgGenImage('assets/images/forkandknife.svg');

  /// File path: assets/images/geo.svg
  SvgGenImage get geo => const SvgGenImage('assets/images/geo.svg');

  /// File path: assets/images/location.svg
  SvgGenImage get location => const SvgGenImage('assets/images/location.svg');

  /// File path: assets/images/merchant_placeholder.svg
  SvgGenImage get merchantPlaceholder =>
      const SvgGenImage('assets/images/merchant_placeholder.svg');

  /// File path: assets/images/noInternet.svg
  SvgGenImage get noInternet =>
      const SvgGenImage('assets/images/noInternet.svg');

  /// File path: assets/images/oh.svg
  SvgGenImage get oh => const SvgGenImage('assets/images/oh.svg');

  /// File path: assets/images/ordersTab.svg
  SvgGenImage get ordersTab => const SvgGenImage('assets/images/ordersTab.svg');

  /// File path: assets/images/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/images/phone.svg');

  /// File path: assets/images/profileTab.svg
  SvgGenImage get profileTab =>
      const SvgGenImage('assets/images/profileTab.svg');

  /// File path: assets/images/ruble.svg
  SvgGenImage get ruble => const SvgGenImage('assets/images/ruble.svg');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// List of all assets
  List<dynamic> get values => [
        chat,
        forkandknife,
        geo,
        location,
        merchantPlaceholder,
        noInternet,
        oh,
        ordersTab,
        phone,
        profileTab,
        ruble,
        splash
      ];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
