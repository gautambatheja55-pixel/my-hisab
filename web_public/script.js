
import { initializeApp } from "https://www.gstatic.com/firebasejs/12.14.0/firebase-app.js";
 
import {
    getDatabase,
    ref,
    push
} from
"https://www.gstatic.com/firebasejs/12.14.0/firebase-database.js"

const firebaseConfig = {
    apiKey: "AIzaSyCfisFUVcgE39J7Fl6DZsngv3SyJb3pn-8",
    authDomain: "incog-c7772.firebaseapp.com",
    databaseURL: "https://incog-c7772-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "incog-c7772",
    storageBucket: "incog-c7772.firebasestorage.app",
    messagingSenderId: "987101017989",
    appId: "1:987101017989:web:fa84da5d8fc564b0e6f6ec"
  };

const recipient=window.location.pathname.split("/")[1];
const app = initializeApp(firebaseConfig);
const db=getDatabase(app);
const sendBtn = document.getElementById("sendBtn");
const messageInput=document.getElementById("message");

console.log("This is the new version running...")
sendBtn.addEventListener("click",() => {
    const messageText=messageInput.value;
    if (messageText.trim()===""){
        alert("Please type something before sending");
        return;
    }
    
    push(ref(db,"users/" + recipient + "/messages"),{
        text:messageText,
        time:Date.now()
    }).then(() => {
        messageInput.value="";
        alert("Anonymous message sent successfully");
    }).catch((error) => {
        console.error("Database Error: ",error);
    });
});