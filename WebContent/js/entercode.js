var vcode = (function(){
  //cache dom
  var $inputs = $("#vcode").find("input");

  //bind events
  $inputs.on('keyup', processInput);
  
  //define methods
  function processInput(e) {
    var x = e.charCode || e.keyCode;
    if( (x == 8 || x == 46) && this.value.length == 0) {
      var indexNum = $inputs.index(this);
      if(indexNum != 0) {
        $inputs.eq($inputs.index(this) - 1).focus();
      }
    }
    
    if( ignoreChar(e) ) 
      return false;
    else if (this.value.length == this.maxLength) {
      $(this).next('input').focus();
    }
  }
  function ignoreChar(e) {
    var x = e.charCode || e.keyCode;
    if (x == 37 || x == 38 || x == 39 || x == 40 )
      return true;
    else 
      return false
  }
  
})();

