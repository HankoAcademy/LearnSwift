//
//  Programmer.swift
//  Optionals
//
//  Created by Hannie Kim on 9/10/21.
//

import Foundation

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
