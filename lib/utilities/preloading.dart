import 'package:flutter_svg/flutter_svg.dart';

preLoadSVG() {
  return Future.wait([
    precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/images/knowledge.svg'),
        null),
    precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/images/media_player.svg'),
        null),
    precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/images/productive.svg'),
        null)
  ]);
}
