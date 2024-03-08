/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ability.png
  AssetGenImage get ability => const AssetGenImage('assets/icons/ability.png');

  /// File path: assets/icons/alert.png
  AssetGenImage get alert => const AssetGenImage('assets/icons/alert.png');

  /// File path: assets/icons/attach_img.png
  AssetGenImage get attachImg =>
      const AssetGenImage('assets/icons/attach_img.png');

  /// File path: assets/icons/bookmark.png
  AssetGenImage get bookmark =>
      const AssetGenImage('assets/icons/bookmark.png');

  /// File path: assets/icons/chat-me.png
  AssetGenImage get chatMe => const AssetGenImage('assets/icons/chat-me.png');

  /// File path: assets/icons/dropdown.png
  AssetGenImage get dropdown =>
      const AssetGenImage('assets/icons/dropdown.png');

  /// File path: assets/icons/edit.png
  AssetGenImage get edit => const AssetGenImage('assets/icons/edit.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/map.png
  AssetGenImage get map => const AssetGenImage('assets/icons/map.png');

  /// File path: assets/icons/menu.png
  AssetGenImage get menu => const AssetGenImage('assets/icons/menu.png');

  /// File path: assets/icons/message.png
  AssetGenImage get message => const AssetGenImage('assets/icons/message.png');

  /// File path: assets/icons/school.png
  AssetGenImage get school => const AssetGenImage('assets/icons/school.png');

  /// File path: assets/icons/search.png
  AssetGenImage get search => const AssetGenImage('assets/icons/search.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        ability,
        alert,
        attachImg,
        bookmark,
        chatMe,
        dropdown,
        edit,
        home,
        map,
        menu,
        message,
        school,
        search
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/background.png');

  /// File path: assets/images/background_home.png
  AssetGenImage get backgroundHome =>
      const AssetGenImage('assets/images/background_home.png');

  /// File path: assets/images/empty_profile.png
  AssetGenImage get emptyProfile =>
      const AssetGenImage('assets/images/empty_profile.png');

  /// File path: assets/images/img_content.png
  AssetGenImage get imgContent =>
      const AssetGenImage('assets/images/img_content.png');

  /// File path: assets/images/img_findy_logo.png
  AssetGenImage get imgFindyLogo =>
      const AssetGenImage('assets/images/img_findy_logo.png');

  /// File path: assets/images/img_icon.png
  AssetGenImage get imgIcon =>
      const AssetGenImage('assets/images/img_icon.png');

  /// File path: assets/images/onboarding_background.png
  AssetGenImage get onboardingBackground =>
      const AssetGenImage('assets/images/onboarding_background.png');

  /// File path: assets/images/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');

  /// File path: assets/images/reason_1.png
  AssetGenImage get reason1 =>
      const AssetGenImage('assets/images/reason_1.png');

  /// File path: assets/images/reason_2.png
  AssetGenImage get reason2 =>
      const AssetGenImage('assets/images/reason_2.png');

  /// File path: assets/images/reason_3.png
  AssetGenImage get reason3 =>
      const AssetGenImage('assets/images/reason_3.png');

  /// File path: assets/images/send.png
  AssetGenImage get send => const AssetGenImage('assets/images/send.png');

  /// File path: assets/images/splash_img.png
  AssetGenImage get splashImg =>
      const AssetGenImage('assets/images/splash_img.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        background,
        backgroundHome,
        emptyProfile,
        imgContent,
        imgFindyLogo,
        imgIcon,
        onboardingBackground,
        profile,
        reason1,
        reason2,
        reason3,
        send,
        splashImg
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
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
