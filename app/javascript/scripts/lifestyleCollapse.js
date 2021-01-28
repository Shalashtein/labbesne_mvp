//-------------- Form Collapse in Lifestyle -------------
window.lifestyleCollapse = function(){
  $('#lifestyle_studies').click(function studyChanged(){
        if($('#lifestyle_studies').is(":checked"))
            $(".lifestyle_study_hours").show();
        else
            $(".lifestyle_study_hours").hide();
 });
$('#lifestyle_works').click(function workChanged(){
        if($('#lifestyle_works').is(":checked")){
          $(".lifestyle_job_types").show();
          $(".lifestyle_work_hours").show();}
        else{
          $(".lifestyle_job_types").hide();
          $(".lifestyle_work_hours").hide();}
 });
};
