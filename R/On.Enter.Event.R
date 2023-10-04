On.Enter.Event <- \(widget, trigger) {
  tags[['script']](
    sprintf('
      $(document).ready(function(){
        $("#%s").keypress(function(e){
          if (e.which == 13) {
            Shiny.onInputChange("%s", Date.now())
          }
        })
      })', 
      widget, trigger
    )
  )
}