import firebase from 'firebase/app'
import 'firebase/app'
import 'firebase/firestore'
import 'firebase/storage'

const config = {
  projectId: process.env.FIREBASE_PROJECT_ID,
  storageBucket: process.env.FIREBASE_STORAGEBUCKET,
}

if (!firebase.apps.length) {
  firebase.initializeApp(config)
}

export default firebase

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCJU7xBaFokrPCTFAkaF_-v1qXNbJjcNCM",
  authDomain: "tk-project-3d1c0.firebaseapp.com",
  projectId: process.env.FIREBASE_PROJECT_ID,
  storageBucket: process.env.FIREBASE_STORAGEBUCKET,
  messagingSenderId: "72427394120",
  appId: "1:72427394120:web:b74aaad0540ed81cbd347d",
  measurementId: "G-SH9681SGP9"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);