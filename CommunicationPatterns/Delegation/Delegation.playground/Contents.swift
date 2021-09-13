import UIKit

// Delegation pattern loves using protocols since it helps set the requirements for the delegate and the one who is delegating
protocol CoffeeOrderable {
    func orderCoffee()
}

struct Manager {
    
    // The delegate can take in any type as long as that type conforms to the CoffeeOrderable protocol
    var delegate: CoffeeOrderable?
    
    func askAssistantToOrderCoffee() {
        delegate?.orderCoffee() // will let the delegate know to start ordering coffee
    }
}

struct Assistant: CoffeeOrderable {
    
    // gets called automatically when assistant is notified to put in the order
    func orderCoffee() {
        print("Order the coffee and pick up the coffee")
    }
}

let assistant = Assistant()

// makes the assistant the delegate of the manager
let manager = Manager(delegate: assistant)
manager.askAssistantToOrderCoffee() // this notifies the delegate (assistant) to order coffee because we've called `delegate?.orderCoffee`



/**
 The Manager hands-off the job of ordering coffee to the Assistant.
 
 The power of delegation is that the Manager doesn't have to know anything about the process of ordering coffee and picking it up. Whether it was from Starbucks or somewhere else or if an Uber was taken. All the manager cares is that coffee comes to the office. This lets someone else (another object or type) to be able to handle all the logic contained to picking up the coffee.
 
 Delegation pattern is used throughout iOS frameworks but an example is with UITableView
 The delegates, UITableViewDelegate and UITableViewDataSource, does all the behind the scenes work to offer the ability to handle events, how cells should be displayed, and more without having any idea about our own specific logic, making it extremely reusable.
 */
