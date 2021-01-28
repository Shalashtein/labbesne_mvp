// ------------------------ Disabled Links on Profile Router
window.disabledLinks = function(){
   $('a[disabled=disabled]').click(function(event){
        event.preventDefault(); // Prevent link from following its href
    });
};
