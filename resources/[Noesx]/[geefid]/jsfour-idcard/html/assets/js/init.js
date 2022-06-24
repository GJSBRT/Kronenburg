$(document).ready(function(){

  const cleanup = () => {
    $('#name').text('');
    $('#dob').text('');
    $('#height').text('');
    $('#signature').text('');
    $('#sex').text('');
    $('#height').text('');
    $('#licenses').html('');
    $('#ratings').html('');
    $('#licenses').hide();
    $('#ratings').hide();
    $('#height').hide();
    $('#dob').hide();
    $('#signature').show();
    $('#dob').show();
    $('#sex').show();
    $('p').css('color', 'black');
    $('#name').removeClass('rainbow');
  }
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      cleanup()
      var type        = event.data.type;
      var userData    = event.data.array['user'][0];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;

      if ( sex.toLowerCase() == 'm' ) {
        sex = 'Man';
      } else {
        sex = 'Vrouw';
      }

      if (licenseData != null) {
        $('#licenses').html('');
        $('#ratings').html('');
        Object.keys(licenseData).forEach(function(key) {
          var type = licenseData[key].label || licenseData[key].type;
          switch (type) {
            case 'drive_bike':
              type = 'A';
              break;
            case 'drive_truck':
              type = 'CE';
              break;
            case 'drive':
              type = 'BE';
              break;
            case 'fly':
              type = 'Prop';
              break;
            case 'flyheli':
              type = 'Heli';
              break;
            case 'flyjet':
              type = 'Jet';
              break;  
            case 'flyjob':
              type = 'Beroeps';
              break;
            case 'flylic':
              type = 'Brevet'
              break;
            default:
              break;
          }
          if ( type === 'A' || type === 'CE' || type === 'BE') {
            $('#card #licenses').append('<p>'+ type +'</p>');
          }else if (type === 'Prop' || type === 'Heli' || type === 'Jet' || type === 'Beroeps' || type === 'Brevet' ){
            $('#card #ratings').append('<p>'+ type +'</p>');
          }
        });
      }
      
      
      $('#name').text(userData.firstname + ' ' + userData.lastname);
      $('#dob').text(userData.dateofbirth);
      $('#signature').text(userData.firstname + ' ' + userData.lastname);
      $('#job').text(userData.rank);
      $('#job').hide();
      $('#sex').text(sex);
      let height = parseInt(userData.height).toFixed(2)/100
      $('#height').text("" + height + " m");
      
   
      if (type == 'police'){
        $('#job').show();
        $('#card').css('background-image', 'url(assets/images/politiepas.png)');
        $('#card').show();
      }else if (type == 'lawyer'){
        $('#job').show();
        $('#card').css('background-image', 'url(assets/images/lawyer.png)');
        $('#card').show();
      } else if (type == 'press'){
        $('#job').show();
        $('p').css('color', '#00000');
        $('#card').css('background-image', 'url(assets/images/press.png)');
        $('#card').show();
      }  else if (type == 'health'){
        $('#height').show();
        $('#card').css('background-image', 'url(assets/images/zorgverzekeringspas.png)');
        $('#card').show();
      }  else if (type == 'firstaidcourse'){
        $('p').css('color', '#FFFFFF');
        $('#card').css('background-image', 'url(assets/images/ehbopas.png)');
        $('#card').show();
      }  else if (type == 'taxi'){
        $('#job').show();
        $('p').css('color', '#FFFFFF');
        $('#card').css('background-image', 'url(assets/images/taxipas.png)');
        $('#card').show();
      }
      else if (type == 'ambulance'){
        $('#job').show();
        $('#card').css('background-image', 'url(assets/images/ambupas.png)');
        $('#card').show();
      }
      else if (type == 'mechanic'){
        $('#job').show();
        $('p').css('color', '#FFFFFF');
        $('#card').css('background-image', 'url(assets/images/anwbpas.png)');
        $('#card').show();
      }
      else if (type == 'kmar'){
        $('#job').show();
        $('#card').css('background-image', 'url(assets/images/kmarpas.png)');
        $('#card').show();
      }
      else if (type == 'fly'){
        $('#ratings').css('display', 'flex');
        $('#height').show();
        $('#card').css('background-image', 'url(assets/images/vliegbrevet.png)');
        $('#card').show();
      }else if (type === 'driver'){
        $('#licenses').css('display', 'flex');
        $('#height').show();
        $('#card').css('background-image', 'url(assets/images/rijbewijs.png)');
        $('#card').show();
      }else if (type == 'staff'){
        $('#job').show();
        $('#name').text(userData.name)
        $('#name').addClass('rainbow');
        $('p').css('color', '#FFFFFF');
        $('#dob').hide();
        $('#sex').hide();
        $('#signature').hide();
        $('#card').css('background-image', 'url(assets/images/staffpas.png)');
        $('#card').show();
      }else if (type == 'tol'){
        $('#card').css('background-image', 'url(assets/images/tolpas.png)');
        $('#signature').hide();
        $('#card').show();
      }else if (type == 'casinoVIP'){
        $('#card').css('background-image', 'url(assets/images/casinoVIP.png)');
        $('#card').show();
        
        $('#signature').addClass('goldFlow');
      }else{
        $('#height').show();
        $('#card').css('background-image', 'url(assets/images/idcard.png)');
        $('#card').show();
      }
      
    }
    else if (event.data.action == 'close') {
      cleanup();
      $('#card').hide();
    }
  });
});
