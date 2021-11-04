var config = {
  apiKey: "AIzaSyD2pXlfdcqqfl_a-Pm0pWATiklnO40jFuw",
  authDomain: "parcial2-7a6f8.firebaseapp.com",
  databaseURL: "https://parcial2-7a6f8-default-rtdb.firebaseio.com",
  projectId: "parcial2-7a6f8",
  storageBucket: "parcial2-7a6f8.appspot.com",
  messagingSenderId: "802367043583",
  appId: "1:802367043583:web:c6eea475556f4fc6ba59ca"
};

// Initialize Firebase
firebase.initializeApp(config);

var messagesRef = firebase.database().ref('sensors');


$('#contactForm').submit(function(e) {
    e.preventDefault();
 
    var newMessageRef = messagesRef.push();
    newMessageRef.set({
        name: $('.fullname').val(),
        email: $('.email').val(),
        subject: $('.subject').val(),
        message: $('.message').val()
    });
 
    $('.success-message').show();
 
    $('#contactForm')[0].reset();
});

// messagesRef.once('value').then((snapshot) => {
//     Object.keys(snapshot.val()).forEach((key) => {
//         document.getElementById("demo").innerHTML = snapshot.val()[key].email;
//         alert(`Name: ${snapshot.val()[key].name}`);
//         alert(`Email: ${snapshot.val()[key].email}`);
//         alert(`Subject: ${snapshot.val()[key].subject}`);
//         alert(`Message: ${snapshot.val()[key].message}`);
//     });
// });

firebase.database().ref('sensors').on('value',(snap)=>{
    Object.keys(snap.val()).forEach((key) => {
        var acel_x = snap.val()[key].val_x;
        var acel_y = snap.val()[key].val_y;
        var acel_z = snap.val()[key].val_z;
        var ilum = snap.val()[key].iluminacion;
        document.getElementById("val_x").innerHTML = acel_x; 
        document.getElementById("val_y").innerHTML = acel_y;
        document.getElementById("val_z").innerHTML = acel_z;
        document.getElementById("iluminacion").innerHTML = ilum; 
        // alert(`Once Name: ${snap.val()[key].name}`);
        // alert(`Once Email: ${snap.val()[key].email}`);
        // alert(`Once Subject: ${snap.val()[key].subject}`);
        // alert(`Once Message: ${snap.val()[key].message}`);
        alert(acel_x);
        
        if (acel_x == 0) {
          // alert("Crash");
          document.location.href = "/crash.html";

        }


    });
  });

// 
// const db = getDatabase();
// const starCountRef = ref(db, 'sensors/' + postId + '/email');
// onValue(starCountRef, (snapshot) => {
//   const data = snapshot.val();
//   alert(`Mi Email ${data}`);
//   updateStarCount(postElement, data);
// });

function check_crash() {
  
}

