#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <Firebase_ESP_Client.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <DHT.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#include "secrets.h"

#define DHTPIN D4   // Pin connected to the DHT11 sensor
#define DHTTYPE DHT11   // DHT 11

DHT dht(DHTPIN, DHTTYPE);
unsigned long timer = 300000;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

String uid;

String databasePath;

String parentPath;

FirebaseJson json;
FirebaseJson jsonC;


WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

int raw=0;
float volt=0.0;

bool continueBool = false;
// Initialize WiFi
void initWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(1000);
  }
  Serial.println(WiFi.localIP());
  Serial.println();
}
String getDay(){
  timeClient.update();
  time_t epochTime = timeClient.getEpochTime();
  struct tm *ptm = gmtime ((time_t *)&epochTime);
  int monthDay = ptm->tm_mday;
  int currentMonth = ptm->tm_mon+1;
  int currentYear = ptm->tm_year+1900;
  return String(monthDay) + "-" + String(currentMonth) + "-" + String(currentYear);
}
String getTime() {
  timeClient.update();
  return timeClient.getFormattedTime();
}
String getPath(){
  String path =getDay() +"/"+ getTime();
  continueBool = true;
  return path;
}

void setup(){
  Serial.begin(9600);
  pinMode(A0, INPUT);
  Serial.println("DHT11 Test");

  dht.begin();
  initWiFi();
  timeClient.begin();


  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.database_url = DATABASE_URL;

  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(4096);

  // Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h

  // Assign the maximum retry of token generation
  config.max_token_generation_retry = 5;

  // Initialize the library with the Firebase authen and config
  Firebase.begin(&config, &auth);

  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  // Print user UID
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);

  // Update database path
  databasePath = "/UsersData/" + uid + "/messurements";
}

void loop(){
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  continueBool = false;
  parentPath = databasePath + "/" + "123";//getPath(); 


  raw = analogRead(A0);
  volt=raw/1023.0;
  volt=volt*4.2;

  if (Firebase.ready()){
    String current= databasePath + "/" + "current";
    json.set("/temperature",String(temperature));
    json.set("/humidity",String(humidity));
    json.set("/voltage",String(volt));
    jsonC.set("/temperature",String(temperature));
    jsonC.set("/humidity",String(humidity));
    jsonC.set("/voltage",String(volt));
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, parentPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
    Serial.printf("Set jsonC... %s\n", Firebase.RTDB.setJSON(&fbdo, current.c_str(), &jsonC) ? "ok" : fbdo.errorReason().c_str());
  }
  delay(timer);
}