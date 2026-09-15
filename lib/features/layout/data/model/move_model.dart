

import '../../../../core/assets/app_image.dart';

class MoveModel {
  String name;
  String image;
  MoveModel({required this.name, required this.image});

  static List<MoveModel> moves = [
    MoveModel(name: "Captain America", image: AppImage.posterCaptainAmerica),
    MoveModel(name: "Iron Man 3", image: AppImage.posterIronMan3),
    MoveModel(name: "Black Widow", image: AppImage.posterBlackWidow),
    MoveModel(name: "Civil War", image: AppImage.posterCivilWar),
    MoveModel(name: "Avengers", image: AppImage.posterAvengers),
    MoveModel(name: "Doctor Strange", image: AppImage.posterDoctorStrange),
    MoveModel(name: "batman", image: AppImage.posterBatman),
  ];
}
