const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);
 
function getNowDate() {
  const now = new Date();
  const utcNow = now.getTime() + (now.getTimezoneOffset() * 60 * 1000);
  const koreaTimeDiff = 9 * 60 * 60 * 1000;
  const koreaNow = new Date(utcNow + koreaTimeDiff);
  let year = koreaNow.getFullYear().toString().slice(-2);
  let month = ("0" + (koreaNow.getMonth() + 1)).slice(-2); 
  let day = ("0" + koreaNow.getDate()).slice(-2); 
  let hour = ("0" + koreaNow.getHours()).slice(-2); 
  let minute = ("0" + koreaNow.getMinutes()).slice(-2); 
  let second = ("0" + koreaNow.getSeconds()).slice(-2); 
  let koreaDate = "20" + year + "년 " + month + "월 " + day + "일 " + hour + "시 " + minute + "분 " + second + "초";
  return koreaDate;
}

exports.sendGasNotifications = functions
  .region('asia-northeast3')
  .firestore
  .document('gas_sensor/{gasId}/ppm_level/{levelId}')
  .onUpdate(
  async (snapshot, context) => {
    koreaDate = getNowDate()
    // Notification details.
    const level = snapshot.after.data().level;
    const detectedGas = context.params.gasId;

    console.log(koreaDate);
    console.log("detectedGas: " + detectedGas + ", level: " + level);
    
    let gas = "";
    if (detectedGas == "detect_ch4") {gas = "메탄가스(CH4)";}
    if (detectedGas == "detect_co") {gas = "일산화탄소(CO)";}
    if (detectedGas == "detect_lpg") {gas = "LPG";}
    
    if (level !== "안전") {
      const payload = {
        notification: {
          title: `Car Keeper ⚠  유해가스 ${level} 경보`,
          body: `${koreaDate}\n${gas} ${level} 감지`,
        }
      };
      // Get the list of device tokens.
      const allTokens = await admin.firestore().collection('device').get();
      const tokens = [];
      allTokens.forEach((tokenDoc) => {
        tokens.push(tokenDoc.id);
      });
      console.log(tokens[0]);
      try {
        if (tokens.length > 0) {
          // Send notifications to all tokens.
          const response = await admin.messaging().sendToDevice(tokens, payload);
        }
      } catch (error) {
        console.log(error);
      }
  }
  });

exports.sendAccessNotifications = functions
  .region('asia-northeast3')
  .firestore
  .document('access_capture/{documentId}')
  .onUpdate(
    async (snapshot, context) => {
      koreaDate = getNowDate()      
      // Notification details.
      const data = snapshot.after.data();
      const accessObject = data.access_object;
      const payload = {
        notification: {
          title: "Car Keeper ⚠ 접근 경보",
          body: `${koreaDate}\n${accessObject} 접근 감지`,
        }
      };
      // Get the list of device tokens.
      const allTokens = await admin.firestore().collection('device').get();
      const tokens = [];
      allTokens.forEach((tokenDoc) => {
        tokens.push(tokenDoc.id);
      });

      try {
        if (tokens.length > 0) {
          // Send notifications to all tokens.
          const response = await admin.messaging().sendToDevice(tokens, payload);
        }
      } catch (error) {
        console.log(error);
      }
  });