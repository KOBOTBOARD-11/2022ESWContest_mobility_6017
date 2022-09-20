// mosquitto 통신으로 서버에 데이터 전송(퍼블리셔)
// 상황:
// yolo 서버에서는 detect_object로 지속적으로 인식되는 물체 저장
// 그 동안 초음파 서버는 접근하는지 계속확인
// 접근하면, 서버는 detect_object를 참고하여 당시 그 데이터를
// detect_object: 물체 접근 시 access_capture가 참고할 실시간으로 업데이트 할 값
// access_capture에 저장하여 access_capture 값 갱신(알림 감.)
// access_capture: 알림 + 앱 로그