import UIKit

// MARK: - Protocol-Oriented Programming

// Protocol that could be used for all different types of products since we're wanting each product to have a name, price, and a way to purchase
protocol ProductProtocol {
    var name: String { get }
    var price: Double { get set }
    
    func buy()
}

// Through a protocol extension, we can provide default functionality through the protocol itself
extension ProductProtocol {
    func sell() {
        print("Sell the \(name)")
    }
}

// We sell Plants
struct Plant: ProductProtocol { // conforms to ProductProtocol
    var name: String
    var price: Double
    var isIndoorPlant: Bool // an additional property so we know if the plant is an indoor or outdoor plant
    
    init(name: String, price: Double, isIndoorPlant: Bool) {
        self.name = name
        self.price = price
        self.isIndoorPlant = isIndoorPlant
    }
    
    func buy() {
        print("Buy a \(name) plant")
    }
}

// We also sell Cars
class Car: ProductProtocol { // conforms to ProductProtocol
    var name: String
    var price: Double
    var isUsed: Bool // an additional property so we konw if the car is used or not
    
    init(name: String, price: Double, isUsed: Bool) {
        self.name = name
        self.price = price
        self.isUsed = isUsed
    }
    
    func buy() {
        print("Buy a \(name) car")
    }
}

// Creating 2 Plant objects
var plant1 = Plant(name: "Pothos", price: 10, isIndoorPlant: true)
var plant2 = Plant(name: "Fuchsia", price: 20, isIndoorPlant: false)
print("Plant1 Name: \(plant1.name), Price: \(plant1.price), Thrives Indoors: \(plant1.isIndoorPlant)")
print("Plant2 Name: \(plant2.name) and Price: \(plant2.price), Thrives Indoors: \(plant1.isIndoorPlant)")

// Creating 2 Car objects
var car1 = Car(name: "Jetta", price: 12000, isUsed: true)
var car2 = Car(name: "Lamborghini", price: 150000, isUsed: false)
print("Car1 Name: \(car1.name), Price: \(car1.price), Is Used: \(car1.isUsed)")
print("Car2 Name: \(car2.name), Price: \(car2.price), Is Used: \(car1.isUsed)")

// Since Plant and Car conform to ProductProtocol, we could create a ProductProtocol array that contains both Plants and Cards
// This is nice because we keep the separation of Plant and Car and still being able to add them to a single array
var products: [ProductProtocol] = [plant1, plant2, car1, car2]

// products property is an array of ProductProtocol so we lose on the additional properties we added for Plant and Car unless we cast them as their original types again
var pothos = products[0] as? Plant
print(pothos?.isIndoorPlant) // we have our Plant type with its unique isIndoorPlant property again

var car = products[2] as? Car
print(car?.isUsed) // we have our Car type with its unique isUsed property again

// Example to show that although name property is Gettable, and price is both Gettable and Settable, we're still updating both property values
pothos?.name = "Bonsai"
pothos?.price = 120

// If we are to use products which is array of ProductProtocol types, you can see that now `name` can no longer be updated, while `price` can be. Test by uncommenting lines 82-85
//products[0].name = "Unnamed Plant"
//products[0].price = 1000
//products[2].name = "Civic"
//products[2].price = 10000

// Protocol Extension Method
pothos?.sell()
car?.sell()

// MARK: - Adding Protocols to Enums

protocol Describable {
    var description: String { get }
}

enum ProgrammingLanguageType: Describable {
    case swift
    case objc
    case javascript

    var description: String {
        switch self {
        case .swift:
            return "Has been the standard for most native iOS apps and was introduced in 2015"
        case .objc:
            return "Used for iOS dev and was the standard before Swift"
        case .javascript:
            return "Used for web dev"
        }
    }
}

let swift: ProgrammingLanguageType = ProgrammingLanguageType.swift
let objc: ProgrammingLanguageType = ProgrammingLanguageType.objc
let javascript: ProgrammingLanguageType = ProgrammingLanguageType.javascript

print(swift.description)
print(objc.description)
print(javascript.description)
