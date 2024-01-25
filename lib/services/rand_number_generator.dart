import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/firebase_functions/firebase_functions.dart';

class NumberGenerator {
  static int generateNumber({
    required String collectionName,
    required List list,
    required int lastNum,
  }) {
    lastNum++;
    list.add(lastNum);
    FirebaseFunctions().saveCollectionIdList(
      collectionName: collectionName,
      generatedIds: list,
      lastNum: lastNum,
    );
    return lastNum;
  }

  static List getGeneratedNumbers() {
    return adDocsIds;
  }

  static int getLastGeneratedNumber() {
    return adDocsLastNum;
  }
}
