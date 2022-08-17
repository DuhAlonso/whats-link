import 'package:mobx/mobx.dart';
import 'package:whats_link/src/repository/shortener_repository_impl.dart';
part 'chama_controller.g.dart';

class ChamaController = ChamaControllerBase with _$ChamaController;

abstract class ChamaControllerBase with Store {
  final _respository = ShortenerRepositoryImpl();

  @observable
  String urlShortener = '';

  @observable
  bool generateLink = false;

  @action
  Future getShortener(String url) {
    final urlShortener = _respository.generateShortener(url);
    return urlShortener;
  }
}
