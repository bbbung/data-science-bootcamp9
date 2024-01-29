pizza_bot <- function() {

    menus <- data.frame(
    menu_name = c("cheese pizza","cheese pizza","cheese pizza","pepperoni pizza","pepperoni pizza","pepperoni pizza",
                  "hawaiian pizza","hawaiian pizza","hawaiian pizza"),
    size = c("small","medium","large","small","medium","large","small","medium","large"),
    prices = c(10,15,20,10,15,20,10,15,20)
    )
    print("Hello, welcome to the Pizza restaurant!")
    print("This is menus")
    print(menus)
    flush.console()
    order <- readline("Do you want to order? : ")
    sum_order <- data.frame(menu_name = c(),size = c(),quantity = c())
    while (TRUE){
    if(order == "yes"){
        pizza_face <- readline("What do you want pizza's face? : ")
        pizza_size <- readline("What do you want pizza's size? : ")
        pizza_quantity <- as.numeric(readline("What do you want pizza's quantity : "))
        print(paste(pizza_face,pizza_size,pizza_quantity))
        sum_order <- rbind(sum_order,data.frame(menu_name = c(pizza_face),size = c(pizza_size),quantity = c(pizza_quantity)))
        order <- readline("Do you want to order another menu? :")

    }else{
        print(sum_order)
        break
    }

    }
    print("Waiter, Could I have a check, please?")
    print("Here is your bill")
    flush.console()
    bill <- merge(sum_order,menus,by = c(1,2) , all.menu_name = TRUE, all.size = TRUE)
    print(bill)
    print(paste("Total_price",sum(bill$quantity*bill$price)))
}
pizza_bot()
