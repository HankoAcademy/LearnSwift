import UIKit

var greeting = "Hello, playground"

class Programmer {
    var desiredJobTitle: String
    var gitHubLink: String
    var favoriteProgrammingLanguage: String?
    
    init(desiredJobTitle: String, gitHubLink: String, favoriteProgrammingLanguage: String?) {
        self.desiredJobTitle = desiredJobTitle
        self.gitHubLink = gitHubLink
        self.favoriteProgrammingLanguage = favoriteProgrammingLanguage
    }
}

// MARK: Unwrapping Optionals
// Unwrapping optionals allows us to be 100% sure that an optional property does indeed have a value and allows us to then use that unwrapped (non-optional) value
// We can use `if let` `guard let` and `switch` statements to unwrap optionals

// IF LET

let raulProgrammer = Programmer(desiredJobTitle: "iOS Platform Lead", gitHubLink: "github.com/hankoacademy", favoriteProgrammingLanguage: "Swift")

let optionalString: String? = raulProgrammer.favoriteProgrammingLanguage
//let requiredString: String = raulProgrammer.favoriteProgrammingLanguage // won't work

if let requiredString = raulProgrammer.favoriteProgrammingLanguage {
    print(requiredString)
}

// GUARD LET

func retrieve(favoriteProgrammingLanguage language: String?) -> String? {
    // In this method we just need to know if the optional is optional or not before we do anything
    guard let unwrappedLanguage = language else {
        return nil
    }
    
    // If optional programming language is nil, I don't care to print it out. That means we should exit the scope early before getting to this line if the optional is nil.
    print("Unwrapped Language: \(unwrappedLanguage)")
    return unwrappedLanguage
}

// SWITCH

let programmerThatLovesSwift = Programmer(desiredJobTitle: "Senior Software Engineer (iOS)", gitHubLink: "github.com/hankoacademy", favoriteProgrammingLanguage: "Swift")

switch programmerThatLovesSwift.favoriteProgrammingLanguage {
case (let unwrappedProgrammingLanguage?):
    print(unwrappedProgrammingLanguage)
case nil:
    print("Programming language is nil")
}
// Prints out "Swift"

let programmerWithoutAFavoriteLanguage = Programmer(desiredJobTitle: "Senior Software Engineer (iOS)", gitHubLink: "github.com/hankoacademy", favoriteProgrammingLanguage: nil)

switch programmerWithoutAFavoriteLanguage.favoriteProgrammingLanguage {
case (let unwrappedProgrammingLanguage?):
    print(unwrappedProgrammingLanguage)
case nil:
    print("Programming language is nil")
}
// Prints out "Programming language is nil"

// MARK: Optional Chaining (?)
// Allows devs to access optional properties. "?" sign added after the optional is optional chaining

let victoriaProgrammer = Programmer(desiredJobTitle: "Senior Software Engineer (iOS)", gitHubLink: "github.com/hankoacademy", favoriteProgrammingLanguage: "Swift")

// favoriteProgrammingLanguage is an optional String type. It still acts like a String, so we can access String properties or methods.
// bobProgrammer.favoriteProgrammingLanguage is not the same as aProgrammer.favoriteProgrammingLanguage?
// the former assume the property is non-optional, while the latter is explicit about presenting itself as an optional
if victoriaProgrammer.favoriteProgrammingLanguage?.contains("Swift") == true {
    print("Bob's favorite language is Swift")
}

// MARK: - Nil-Coalescing Operator (??)
// Instead of unwrapping, it uses a default value we specify if the optional is nil

// Using the default value if optional is nil
var sonnieProgrammer = Programmer(desiredJobTitle: "CEO of Apple", gitHubLink: "github.com/hankoacademy", favoriteProgrammingLanguage: nil)
var favoriteProgrammingLanguage: String = sonnieProgrammer.favoriteProgrammingLanguage ?? "Swift"
print(favoriteProgrammingLanguage)

// Not having the use the default value when optional is NOT nil
var sonnieProgrammerObjectiveC = Programmer(desiredJobTitle: "CEO of Apple", gitHubLink: "github.com/hankoacademy", favoriteProgrammingLanguage: "Objective-C")
var sonniesFavoriteProgrammingLanguage: String = sonnieProgrammerObjectiveC.favoriteProgrammingLanguage ?? "Favorite language is nil"
print(sonniesFavoriteProgrammingLanguage)


/**
 Unconditional Unwrapping
 
 */
