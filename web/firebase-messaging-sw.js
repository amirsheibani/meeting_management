importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyBXk4uU9IKcCdmXbFTVwqJZ9WwfNibslNU",
    authDomain: "fluttertest-59607.firebaseapp.com",
    projectId: "fluttertest-59607",
    storageBucket: "fluttertest-59607.appspot.com",
    messagingSenderId: "782955578261",
    appId: "1:782955578261:web:20c1b165db4cb76c53ec9c",
    measurementId: "G-SMPVGR6V0C"
};
firebase.initializeApp(firebaseConfig);
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});