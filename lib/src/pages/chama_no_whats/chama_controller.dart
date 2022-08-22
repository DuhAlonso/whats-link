import 'package:mobx/mobx.dart';
import 'package:chama/src/repository/shortener_repository_impl.dart';
part 'chama_controller.g.dart';

class ChamaController = ChamaControllerBase with _$ChamaController;

abstract class ChamaControllerBase with Store {
  final _respository = ShortenerRepositoryImpl();

  @observable
  String urlShortener = '';

  @observable
  bool generateLink = false;

  @action
  Future<String> getShortener(String url) async {
    final urlS = await _respository.generateShortener(url);

    urlShortener = urlS;
    return urlS;
  }
}
