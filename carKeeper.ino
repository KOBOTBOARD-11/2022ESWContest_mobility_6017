#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif

#include <Firebase_ESP_Client.h>

// Provide the token generation process info.
#include <addons/TokenHelper.h>

/* 1. Define the WiFi credentials */
// #define WIFI_SSID "KOBOT"
// #define WIFI_PASSWORD "zhqhtghkdlxld!!"

#define WIFI_SSID "사용자 Wifi "
#define WIFI_PASSWORD "Wifi 비밀번호"
/* 2. Define the API Key */
// #define API_KEY "AIzaSyAALDWMeRogfY8G0ZdVK8jVCzWYjPfxybQ"
#define API_KEY "자신의 Firebase 프로젝트 API 인증키"

/* 3. Define the project ID */
// #define FIREBASE_PROJECT_ID "esc-car-keeper"
#define FIREBASE_PROJECT_ID "Firebase 프로젝트 ID"

/* 4. Define the user Email and password that alreadey registerd or added in your project */
// #define USER_EMAIL "kobot@kookmin.ac.kr"
// #define USER_PASSWORD "zhqhtghkdlxld!!"
#define USER_EMAIL "Firebase에 등록한 User 이메일"
#define USER_PASSWORD "User 이메일 비밀번호"

// Define Firebase Data object
#include <MQUnifiedsensor.h>
#define         Board                   ("Arduino UNO")
#define         Pin                     (A0)  //Analog input 4 of your arduino
#define         Type                    ("MQ-9") //MQ9
#define         Voltage_Resolution      (5)
#define         ADC_Bit_Resolution      (10) // For arduino UNO/MEGA/NANO
#define         RatioMQ9CleanAir        (9.6) //RS / R0 = 60 ppm 
MQUnifiedsensor MQ9(Board, Voltage_Resolution, ADC_Bit_Resolution, Pin, Type);

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long dataMillis = 0;
float LPG = MQ9.readSensor(); 
float CH4 = MQ9.readSensor(); 
float CO = MQ9.readSensor(); 

void setup()
{
    MQ9Init();
    FirebaseInit();
    ESP.wdtDisable();
}
void loop()
{
  ESP.wdtDisable();
  ReadMQ9();
  ReadGasData();  
}


void MQ9Init(){
  Serial.begin(115200); //Init serial port
  //Set math model to calculate the PPM concentration and the value of constants
  MQ9.setRegressionMethod(1); //_PPM =  a*ratio^b
  MQ9.init(); 

  float calcR0 = 0;
  for(int i = 1; i<=10; i ++)
  {
    MQ9.update(); // Update data, the arduino will read the voltage from the analog pin
    calcR0 += MQ9.calibrate(RatioMQ9CleanAir);

  }
  MQ9.setR0(calcR0/10);
}

void FirebaseInit(){
   Serial.begin(115200);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print(".");
        delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    /* Assign the api key (required) */
    config.api_key = API_KEY;

    /* Assign the user sign in credentials */
    auth.user.email = USER_EMAIL;
    auth.user.password = USER_PASSWORD;

    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

#if defined(ESP8266)
    // In ESP8266 required for BearSSL rx/tx buffer for large data handle, increase Rx size as needed.
    fbdo.setBSSLBufferSize(2048 /* Rx buffer size in bytes from 512 - 16384 */, 2048 /* Tx buffer size in bytes from 512 - 16384 */);
#endif

    // Limit the size of response payload to be collected in FirebaseData
    fbdo.setResponseSize(2048);

    Firebase.begin(&config, &auth);

    Firebase.reconnectWiFi(true);
}


void ReadMQ9(){
  MQ9.update(); 

  MQ9.setA(1000.5); MQ9.setB(-2.186); 
  LPG = MQ9.readSensor(); 
  MQ9.setA(4269.6); MQ9.setB(-2.648); 
  CH4 = MQ9.readSensor(); 
  MQ9.setA(599.65); MQ9.setB(-2.244); 
  CO = MQ9.readSensor(); 
  

  Serial.print("|    "); Serial.print(LPG);
  Serial.print("    |    "); Serial.print(CH4);
  Serial.print("    |    "); Serial.print(CO); 
  Serial.println("    |");
  delay(500);  
}


void ReadGasdata(){
  if (Firebase.ready() && (millis() - dataMillis > 1000 || dataMillis == 0))
    {
        dataMillis = millis();

        Serial.print("Commit a document (set server value, update document)... ");
        // The dyamic array of write object fb_esp_firestore_document_write_t.
        std::vector<struct fb_esp_firestore_document_write_t> writes;
        
        // ====================================================Setting CO ===============================================================
        //업데이트 할 정보 입력 CO
        struct fb_esp_firestore_document_write_t update_write_CO; // C0데이터 업데이트
        update_write_CO.type = fb_esp_firestore_document_write_type_update; // 데이터를 지속적으로 업데이트 
        FirebaseJson content_CO; 
        String documentPath_CO = "gas_sensor/detect_co"; // 문서경로 입력
        update_write_CO.update_document_path = documentPath_CO.c_str(); //경로 입력
        content_CO.set("fields/ppm/integerValue", String(int(CO))); 
        update_write_CO.update_document_content = content_CO.raw();
        // update_write.update_masks = "count,random";
        writes.push_back(update_write_CO);

        //업데이트 할 정보 입력  CO_Alarm
        struct fb_esp_firestore_document_write_t update_write_CO_Alarm; // C0데이터 업데이트
        update_write_CO_Alarm.type = fb_esp_firestore_document_write_type_update; // 데이터를 지속적으로 업데이트 
        FirebaseJson content_CO_Alarm; 
        String documentPath_CO_Alarm = "gas_sensor/detect_co/ppm_level/level"; // 문서경로 입력
        update_write_CO_Alarm.update_document_path = documentPath_CO_Alarm.c_str(); //경로 입력
        String ararm_co;
        if(int(CO) >= 800){
          ararm_co = "위험";
        } 
        else if (int(CO) >=40){
          ararm_co = "주의";
        }
        else{
          ararm_co = "안전";          
        }
        content_CO_Alarm.set("fields/level/stringValue", ararm_co.c_str()); 
        update_write_CO_Alarm.update_document_content = content_CO_Alarm.raw();
        // update_write.update_masks = "count,random";
        writes.push_back(update_write_CO_Alarm);

      // ====================================================Setting CO ===============================================================
      


      // ====================================================Setting CH4 ===============================================================
        struct fb_esp_firestore_document_write_t update_write_CH4;
        update_write_CH4.type = fb_esp_firestore_document_write_type_update;
        FirebaseJson content_CH4;
        String documentPath_CH4 = "gas_sensor/detect_ch4";
        update_write_CH4.update_document_path = documentPath_CH4.c_str();
        content_CH4.set("fields/ppm/integerValue", String(int(CH4)));
        update_write_CH4.update_document_content = content_CH4.raw();
        writes.push_back(update_write_CH4);

        //업데이트 할 정보 입력  CH4_Alarm
        struct fb_esp_firestore_document_write_t update_write_CH4_Alarm; // C0데이터 업데이트
        update_write_CH4_Alarm.type = fb_esp_firestore_document_write_type_update; // 데이터를 지속적으로 업데이트 
        FirebaseJson content_CH4_Alarm; 
        String documentPath_CH4_Alarm = "gas_sensor/detect_ch4/ppm_level/level"; // 문서경로 입력
        update_write_CH4_Alarm.update_document_path = documentPath_CH4_Alarm.c_str(); //경로 입력
        String ararm_ch4;
       if(int(CH4) >= 2500){
          ararm_ch4 = "위험";
        } 
        else if (int(CH4) >=1000){
          ararm_ch4 = "주의";
        }
        else{
          ararm_ch4 = "안전";
        }
        content_CH4_Alarm.set("fields/level/stringValue", ararm_ch4.c_str()); 
        update_write_CH4_Alarm.update_document_content = content_CH4_Alarm.raw();
        // update_write.update_masks = "count,random";
        writes.push_back(update_write_CH4_Alarm);
        // ====================================================Setting CH4 ===============================================================
        


        // ====================================================Setting LPG ===============================================================
        struct fb_esp_firestore_document_write_t update_write_LPG;
        update_write_LPG.type = fb_esp_firestore_document_write_type_update;
        FirebaseJson content_LPG;
        String documentPath_LPG = "gas_sensor/detect_lpg";
        update_write_LPG.update_document_path = documentPath_LPG.c_str();
        content_LPG.set("fields/ppm/integerValue", String(int(LPG)));
        update_write_LPG.update_document_content = content_LPG.raw();
        writes.push_back(update_write_LPG);

        //업데이트 할 정보 입력  LPG_Alarm
        struct fb_esp_firestore_document_write_t update_write_LPG_Alarm; // C0데이터 업데이트
        update_write_LPG_Alarm.type = fb_esp_firestore_document_write_type_update; // 데이터를 지속적으로 업데이트 
        FirebaseJson content_LPG_Alarm; 
        String documentPath_LPG_Alarm = "gas_sensor/detect_lpg/ppm_level/level"; // 문서경로 입력
        update_write_LPG_Alarm.update_document_path = documentPath_LPG_Alarm.c_str(); //경로 입력
        String ararm_lpg;
        if(int(LPG) >= 2500){
          ararm_lpg = "위험";
        } 
        else if (int(LPG) >=1000){
          ararm_lpg = "주의";
        }
        else{
          ararm_lpg = "안전";
        }
        content_LPG_Alarm.set("fields/level/stringValue", ararm_lpg.c_str()); 
        update_write_LPG_Alarm.update_document_content = content_LPG_Alarm.raw();
        // update_write.update_masks = "count,random";
        writes.push_back(update_write_LPG_Alarm);
        // ====================================================Setting LPG ===============================================================
        



        if (Firebase.Firestore.commitDocument(&fbdo, FIREBASE_PROJECT_ID, "" /* databaseId can be (default) or empty */, writes /* dynamic array of fb_esp_firestore_document_write_t */, "" /* transaction */))
            Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
        else
            Serial.println(fbdo.errorReason());
    }
}