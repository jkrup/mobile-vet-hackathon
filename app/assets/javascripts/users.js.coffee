jQuery ->
   updateDashboard()

   $(document).delegate ".accept_link", "click", (e) ->
    a = $(@).data("address")
    #console.log(a)
    removeLastFromMap()
    addToMap(a)
     
   $(document).delegate ".decline_link", "click", (e) ->
    #console.log("killlll")
    removeLastFromMap() 
    #initialize_google_maps()

updateDashboard = () ->
   client_id = $("#client").data("id")
   $.getScript("/users/"+client_id+".js")
   setTimeout(updateDashboard, 2000)


