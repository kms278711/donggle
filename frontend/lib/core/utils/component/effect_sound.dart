import 'package:just_audio/just_audio.dart';

AudioPlayer effectPlayer = AudioPlayer();

Future<void> effectPlaySound(String path, double volume) async {
  try {
    await effectPlayer.setAsset(path); // 오디오 파일의 URL을 설정
    await effectPlayer.setVolume(volume);
    await effectPlayer.play(); // 오디오 재생 시작
  } catch (e) {
    print("오류 발생: $e");
  }
}
