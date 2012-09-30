jQuery ->
   updateDashboard()

updateDashboard = () ->
   client_id = $("#client").data("id")
   $.getScript("/users/"+client_id+".js")
   setTimeout(updateDashboard, 2000)
