<!DOCTYPE HTML>
<html>
<head>
<title>NICUs</title>
<style>

      #map {
        height:60%;
      }
      
	  html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>

</head>
<body>

	<!--Reso-->
			<h3 id="reso" style="margin-top:100px"> Location ..... </h3>	 		
  <div id="floating-panel">
  <br><br>
	<b><hr>First choose from start MyLocation and choose closer NICU <hr></b>
    <b>Your location "A"</b>
    <select id="start">
      <option value=""> My Location </option>

  </select>
    <b>"B" is NICUs have space </b>
    <select id="end">
      
            <option value="30.6355657,31.0924768">Berket Elsap3 Hospital </option>
      <option value="30.4419813,30.9630092">sers elyan Hospital</option>
      <option value="30.2958669,30.9911439">ashmoon Hospital</option>
      <option value="30.472076,30.9295633">monof Hospital</option>
      <option value="30.6844904,30.9524721">tala Hospital</option>
      <option value="30.5526188,31.1411875">quesna Hospital</option>
      <option value="30.082741,31.354556">elgam3ya elshar3ya Hospital</option>
      <option value="30.1269646,31.3227974">tabarak Hospital</option>
      <option value="30.0970265,31.3122287">elganzory Hospital</option>
      <option value="31.1911269,29.9398336">alex Hospital</option>
	  <option value="31.2299698,29.9543735">agyal Hospital</option>

	  
	  <!--    
	<option value="31.3543,27.2373">Marsa matroh </option>
    -->
	</select>
    </div>
    <div id="map"></div>
    &nbsp;
    <div id="warnings-panel"></div>
    
	<script>
	  var x;
	  var y;
	var v;
	
		function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2-lat1);  // deg2rad below
  var dLon = deg2rad(lon2-lon1); 
  var a = 
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
    Math.sin(dLon/2) * Math.sin(dLon/2)
    ; 
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
  var d = R * c; // Distance in km
  return d;
}

function deg2rad(deg) {
  return deg * (Math.PI/180)
}


      function initMap() {
	  
	  //......../
	    var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 6
        });
        var infoWindow = new google.maps.InfoWindow({map: map});

        // Try HTML5 geolocation.
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
	/// Why ///
            infoWindow.setPosition(pos);
	    	 x=pos.lat;
			 y=pos.lng;
	 v =x+','+y;
    
	document.getElementById('reso').innerHTML=v;
     
	 infoWindow.setContent('Location Found ...');        
			//infoWindow.setContent('Location found.');
            map.setCenter(pos);
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        } 
			
			
	  //.........../
        var markerArray = [];
         // 31.2001° N, 29.9187° E
        // Instantiate a directions service.
        var directionsService = new google.maps.DirectionsService;

        // Create a map and center it on Manhattan.
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
		  
          center: {lat: 30.7865, lng: 31.0004}
        });

        // Create a renderer for directions and bind it to the map.
        var directionsDisplay = new google.maps.DirectionsRenderer({map: map});

        // Instantiate an info window to hold step text.
        var stepDisplay = new google.maps.InfoWindow;

        // Display the route between the initial start and end selections.
        calculateAndDisplayRoute(
            directionsDisplay, directionsService, markerArray, stepDisplay, map);
        // Listen to change events from the start and end lists.
        
		var onChangeHandler = function() {
          calculateAndDisplayRoute(
              directionsDisplay, directionsService, markerArray, stepDisplay, map);
        
		// ***************************  code will be here  *********************************************************
	var ed= document.getElementById('end').value;
	 
	  var edd = ed.split(",");	  
		 var lat2   = edd[0];
		 var lon2   = edd[1];
	
	var DD=	getDistanceFromLatLonInKm(x,y,lat2,lon2);
	var t = Math.round(DD);
//alert(t);
//alert(t/100);
    //var D=	distance(lat1,lon1,lat2,lon2,"K");
		//alert("---- The Distance In Km Algo1 --------" + D );	 
		alert(" The Distance In Km Is "   +  "["  + DD  +"]" );	
		alert(" The Time In H With Speed 100 Km/H Is  "   +  "["  + DD/100  +"]" );	
		
		// ****************************************************************************
		
		};
		
        document.getElementById('start').addEventListener('change', onChangeHandler);
        document.getElementById('end').addEventListener('change', onChangeHandler);
      }

      function calculateAndDisplayRoute(directionsDisplay, directionsService,
          markerArray, stepDisplay, map) {
        // First, remove any existing markers from the map.
        for (var i = 0; i < markerArray.length; i++) {
          markerArray[i].setMap(null);
        }

        // Retrieve the start and end locations and create a DirectionsRequest using
        // WALKING directions.
     //////////////////////////////////////////////////////////////////////////////////////////////////
		var Loc=document.getElementById('reso').innerHTML;	
		directionsService.route({
        ///////  origin: document.getElementById('start').value,
		
		origin: document.getElementById('start').value=Loc,
		  destination: document.getElementById('end').value,
        
		travelMode: 'WALKING'
        }, function(response, status) {
          // Route the directions and pass the response to a function to create
          // markers for each step.
          if (status === 'OK') {
            document.getElementById('warnings-panel').innerHTML =
                '<b>' + response.routes[0].warnings + '</b>';
            directionsDisplay.setDirections(response);
            showSteps(response, markerArray, stepDisplay, map);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      }

function showSteps(directionResult, markerArray, stepDisplay, map) {
        // For each step, place a marker, and add the text to the marker's infowindow.
        // Also attach the marker to an array so we can keep track of it and remove it
        // when calculating new routes.
        var myRoute = directionResult.routes[0].legs[0];
        for (var i = 0; i < myRoute.steps.length; i++) {
          var marker = markerArray[i] = markerArray[i] || new google.maps.Marker;
          marker.setMap(map);
          marker.setPosition(myRoute.steps[i].start_location);
          attachInstructionText(
              stepDisplay, marker, myRoute.steps[i].instructions, map);
        }
      }

      function attachInstructionText(stepDisplay, marker, text, map) {
        google.maps.event.addListener(marker, 'click', function() {
          // Open an info window when the marker is clicked on, containing the text
          // of the step.
          stepDisplay.setContent(text);
          stepDisplay.open(map, marker);
        });
      }
	  
      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
      }
	  
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCmYO5bQQyAO-vbVT_Z1O_nzI4tfSeiBF0&callback=initMap">
    </script>	
		<!--Reso-->
	
</body>
</html>