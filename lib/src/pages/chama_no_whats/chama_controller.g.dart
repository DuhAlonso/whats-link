// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chama_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChamaController on ChamaControllerBase, Store {
  late final _$urlShortenerAtom =
      Atom(name: 'ChamaControllerBase.urlShortener', context: context);

  @override
  String get urlShortener {
    _$urlShortenerAtom.reportRead();
    return super.urlShortener;
  }

  @override
  set urlShortener(String value) {
    _$urlShortenerAtom.reportWrite(value, super.urlShortener, () {
      super.urlShortener = value;
    });
  }

  late final _$generateLinkAtom =
      Atom(name: 'ChamaControllerBase.generateLink', context: context);

  @override
  bool get generateLink {
    _$generateLinkAtom.reportRead();
    return super.generateLink;
  }

  @override
  set generateLink(bool value) {
    _$generateLinkAtom.reportWrite(value, super.generateLink, () {
      super.generateLink = value;
    });
  }

  late final _$ChamaControllerBaseActionController =
      ActionController(name: 'ChamaControllerBase', context: context);

  @override
  Future<dynamic> getShortener(String url) {
    final _$actionInfo = _$ChamaControllerBaseActionController.startAction(
        name: 'ChamaControllerBase.getShortener');
    try {
      return super.getShortener(url);
    } finally {
      _$ChamaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
urlShortener: ${urlShortener},
generateLink: ${generateLink}
    ''';
  }
}
