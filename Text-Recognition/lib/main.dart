import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_recognition_flutter/result_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {

  bool isPermissionGranted = false; //권한

  late final Future<void> _future;
  //카메라 컨트롤러
  CameraController? cameraController;

  //TextRecognizer 객체, 한국어 설정
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        cameraController != null &&
        cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);
                    return Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7, // 높이를 조정
                        width: double.infinity, // 너비를 최대로 설정
                        child: AspectRatio(
                          aspectRatio: cameraController!.value.aspectRatio, // 카메라의 종횡비를 유지
                          child: CameraPreview(cameraController!),
                        ),
                      ),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              appBar: AppBar(
                title: const Text('Text Recognition'),
              ),
              backgroundColor: isPermissionGranted ? Colors.transparent : null,
              body: isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 67.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: scanImage,
                              child: const Text('텍스트 인식하기', style: TextStyle(color: Colors.black,fontSize: 15)),
                              style: ElevatedButton.styleFrom(
                                // 버튼의 크기를 조정
                                minimumSize: Size(400, 60), // 너비와 높이를 조정
                              ),
                            ),
                          ),
                        ),
                      ],
              )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: const Text(
                          'Camera permission denied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  //카메라 권한을 요청하고, 권한 상태를 isPermissionGranted 변수에 저장
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (cameraController != null) {
      _cameraSelected(cameraController!.description);
    }
  }

  void _stopCamera() {
    if (cameraController != null) {
      cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (cameraController != null) {
      return;
    }

    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await cameraController!.initialize();
    await cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  //카메라로 이미지를 캡처하고, 그 이미지를 텍스트 인식기로 전달하여 텍스트를 인식
  Future<void> scanImage() async {
    if (cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final pictureFile = await cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);



      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ResultScreen(text: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
