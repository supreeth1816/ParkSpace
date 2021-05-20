#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>

#define FIREBASE_HOST "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "a3KBYGWA7k2RNoMkto99g6ODjtdba9drCIwlzxgN"
#define WIFI_SSID "ACTFIBERNET" 
#define WIFI_PASSWORD "act12345"
FirebaseData firebaseData;


const int trig1=D0;
const int echo1=D1;
String status;
long duration;
int distance;
void setup() {

  pinMode(trig1, OUTPUT);
  pinMode(echo1, INPUT);
    Serial.begin(115200);                                                      
  Serial.println("Serial communication started\n\n");  
           
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                                    
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Connected to ");
  Serial.println(WIFI_SSID);
  Serial.print("IP Address is : ");
  Serial.println(WiFi.localIP());                                            
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);   
  Firebase.reconnectWiFi(true);
  delay(1000);
}

void loop() {
  digitalWrite(trig1, HIGH);
  delay(15);
  digitalWrite(trig1, LOW);
  duration = pulseIn(echo1, HIGH);
  // The ultrasonic module is placed 20cm above from 1m tank.
  distance = (duration / 58);
  if(distance < 20){
    status = "ACTIVE";
  }
  else{
    status = "EMPTY";
  }
  

 Firebase.setInt(firebaseData, "/parkingdistance", distance);
 Firebase.setString(firebaseData, "/parkingstatus", status);
 }
