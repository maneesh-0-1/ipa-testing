importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCuCm7FypigEfCdFtQLOnlH0AakED96-lE",
  authDomain: "blaban-2d4e2.firebaseapp.com",
  projectId: "blaban-2d4e2",
  storageBucket: "blaban-2d4e2.firebasestorage.app",
  messagingSenderId: "237762489358",
  appId: "1:237762489358:web:023d1779b28949679fa05f",
  measurementId: "G-KTV20S7DLB"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});