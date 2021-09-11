//
//  ViewController.swift
//  Optionals
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class ViewController: UIViewController {
            
    var contentView: ContentView!

    override func loadView() {
        contentView = ContentView(buttonAction: { [weak self] in
            self?.resetLabels()
        })
        
        view = contentView
    }
    
    private func resetLabels() {

        print(contentView.textFieldStackView.jobTitleTextField.text)
        print(contentView.textFieldStackView.linesOfCodeWrittenTextField.text)
        print(contentView.textFieldStackView.favoriteProgrammingLanguageTextField.text)
        
        let jobTitle = contentView.textFieldStackView.jobTitleTextField.text
        let gitHubLink = contentView.textFieldStackView.linesOfCodeWrittenTextField.text
        let favoriteProgrammingLanguage = contentView.textFieldStackView.favoriteProgrammingLanguageTextField.text
        
        let programmer = Programmer(desiredJobTitle: <#T##String#>, gitHubLink: <#T##String#>, favoriteProgrammingLanguage: <#T##String?#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display a stack view
        // if property is nil then hide labels that are used to display the optional value
        // if property exists, then display that label again
        // text fields to take user input that creates the object
        // button to check
    }
}
