library example;

import 'package:flutter_js_asset/annotations.dart';

part 'example.g.dart';

@TextAsset('asset:example/web/dist/bundle.js')
const String jsCode = $jsCodeContent;
