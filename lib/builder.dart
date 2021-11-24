library builder;

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

Future<String> loadAsset(BuildStep buildStep, ConstantReader annotation) async {
  var assetPath = annotation.read('path').stringValue;
  var assetId = AssetId.resolve(Uri.parse(assetPath), from: buildStep.inputId);
  return buildStep.readAsString(assetId);
}

class BundleGenerator extends GeneratorForAnnotation<TextAsset> {

  BundleGenerator();

  @override
  Future generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    var variableElement = element as VariableElement;
    if (!(variableElement.isConst &&
        variableElement.type.toString() == 'String')) {
      throw 'variable: ${variableElement.displayName} must be a constant String';
    }
    String content = await loadAsset(buildStep, annotation);
    return Future.value(
        "const String \$${variableElement.name}Content = r'''${content}''';");
  }
}

Builder bundleBuilder(BuilderOptions options) =>
    SharedPartBuilder([BundleGenerator()], 'flutter_js_asset');
