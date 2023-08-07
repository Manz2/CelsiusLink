#include <Arduino.h>
#include <WiFiUdp.h>
#include <DHT.h>
#include <NTPClient.h>
#include <Firebase_ESP_Client.h>
#include <ESP8266WiFi.h>
#include <Wire.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#include "secrets.h"

#define DHTPIN D4   // Pin connected to the DHT11 sensor
#define DHTTYPE DHT11   // DHT 11

DHT dht(DHTPIN, DHTTYPE);

//time between messurements
unsigned long timer = 300000;



String databasePath;
String parentPath;
FirebaseJson json;
FirebaseJson jsonC;

String uid;

FirebaseData data;
FirebaseAuth auth;
FirebaseConfig config;

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

int raw=0;
float volt=0.0;


void connectWifi(){
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.println("WiFi Connected....IP Address:");
  Serial.println(WiFi.localIP());
  Serial.println();
}

void setup() {
  Serial.begin(9600);
  Serial.println("DHT11 Test");
  dht.begin();
  connectWifi();
  timeClient.begin();

  pinMode(A0, INPUT);

  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.database_url = DATABASE_URL;

  Firebase.reconnectWiFi(true);
  data.setResponseSize(4096);

  config.token_status_callback = tokenStatusCallback;
  config.max_token_generation_retry = 5;

  Firebase.begin(&config, &auth);

  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }

  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);

  databasePath = "/Data/" + uid + "/messurements";

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


void loop() {
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();

  raw = analogRead(A0);
  volt=raw/1023.0;
  volt=volt*4.2;

  if (Firebase.ready()){
    parentPath= databasePath + "/" + getDay() +"/"+ getTime();
    String current= databasePath + "/" + "current";
    json.set("/temperature",String(temperature));
    json.set("/humidity",String(humidity));
    json.set("/voltage",String(volt));
    jsonC.set("/temperature",String(temperature));
    jsonC.set("/humidity",String(humidity));
    jsonC.set("/voltage",String(volt));
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&data, parentPath.c_str(), &json) ? "ok" : data.errorReason().c_str());
    Serial.printf("Set jsonC... %s\n", Firebase.RTDB.setJSON(&data, current.c_str(), &jsonC) ? "ok" : data.errorReason().c_str());
  }
  delay(timer);
}
