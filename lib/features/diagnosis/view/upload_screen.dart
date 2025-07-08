// C:\Users\sptzk\Desktop\t0703\lib\features\diagnosis\view\upload_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // image_picker 임포트
import 'dart:io'; // File 클래스 사용을 위해 추가

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _selectedImage; // 선택된 이미지를 저장할 변수

  // 이미지 선택 함수
  void _selectImage() async {
    final ImagePicker picker = ImagePicker();

    // 사용자에게 갤러리 또는 카메라 선택 옵션 제공
    final result = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 촬영'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      final XFile? image = await picker.pickImage(source: result);

      setState(() {
        _selectedImage = image;
      });

      // 이미지가 성공적으로 선택되었는지 사용자에게 알림
      if (_selectedImage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 선택 완료: ${_selectedImage!.name}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미지 선택 취소됨')),
        );
      }
    }
  }

  // 진단 제출 함수
  void _submitDiagnosis() {
    if (_selectedImage != null) { // 이미지가 선택되었는지 확인
      // TODO: 진단 요청 API 호출 로직 구현
      // _selectedImage.path를 사용하여 이미지 파일에 접근하거나,
      // _selectedImage.readAsBytes()를 사용하여 이미지 바이트를 얻을 수 있습니다.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('진단 제출 진행 중...')),
      );
      context.go('/result'); // 결과 화면으로 이동
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('먼저 이미지를 선택해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사진 진단'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home'); // 홈 화면으로 이동
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('진단할 사진을 업로드하세요'),
            const SizedBox(height: 20),
            // 이미지가 선택되면 미리보기를 표시
            _selectedImage != null
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect( // 이미지가 컨테이너 밖으로 나가지 않도록 클리핑
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file( // File 이미지 위젯 사용
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(child: Text('이미지 로드 실패')),
                      ),
                    ),
                  )
                : const Text('선택된 이미지가 없습니다.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('+ 사진 선택'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedImage != null ? _submitDiagnosis : null, // 이미지가 선택되었을 때만 제출 버튼 활성화
              child: const Text('제출'),
            ),
          ],
        ),
      ),
    );
  }
}
