import 'package:get/get.dart';
import 'package:quiz/firebase/firebase_configs.dart';
import 'package:quiz/utils/utils.dart';

class FireBaseStorageService extends GetxService{
   Future<String?> getImage(String? imageName) async {
    if (imageName == null) return null;

    try {
      var urlref = firebaseStorage
          .child('quiz_paper_images')
          .child('${imageName.toLowerCase()}.png');
      var url = await urlref.getDownloadURL();
      return url;
    } on Exception catch (e) {
      Logger.get().log(e);
      return null;
    }
  }
}