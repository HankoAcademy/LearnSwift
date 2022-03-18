//
//  ViewController.swift
//  RandomVacationLocation
//
//  Created by Han Kim on 3/12/22.
//

import UIKit

struct VacationLocation {
    let name: String
    let departureDateString: String
    var image: UIImage?
}

class ViewController: UIViewController {
    
    let vacationLocations: [VacationLocation] = [
        VacationLocation(name: "Bora Bora", departureDateString: "April 10" , image: UIImage(named: "borabora")),
        VacationLocation(name: "Dubai", departureDateString: "May 8", image: UIImage(named: "dubai")),
        VacationLocation(name: "Los Angeles", departureDateString: "April 11", image: UIImage(named: "los_angeles")),
        VacationLocation(name: "Nashville", departureDateString: "June 12", image: UIImage(named: "nashville")),
        VacationLocation(name: "Santorini", departureDateString: "March 28", image: UIImage(named: "santorini"))
    ]
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let vacationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "Vacation Name"
        return label
    }()
    
    let departureDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.text = "Test Date"
        return label
    }()
    
    let vacationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bora Bora") // to be removed
        return imageView
    }()
    
    let randomizeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My Next Vacation", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
        
        let vacation = vacationLocations.first
        updateViews(withVacation: vacation)
    }
    
    func addSubviews() {
        stackView.addArrangedSubview(vacationNameLabel)
        stackView.addArrangedSubview(departureDateLabel)
        stackView.addArrangedSubview(vacationImageView)
        
        view.addSubview(randomizeButton)
        view.addSubview(stackView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vacationImageView.heightAnchor.constraint(equalToConstant: 200),
            vacationImageView.widthAnchor.constraint(equalToConstant: 200),
            
            randomizeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomizeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func randomButtonPressed() {
        print("my next vacation button pressed")
        
        let randomVacation = randomizedVacation()
        updateViews(withVacation: randomVacation)
    }
    
    func randomizedVacation() -> VacationLocation? {
//        let randomInt = Int.random(in: 0..<vacationLocations.count)
//        return vacationLocations[randomInt]
        
        return vacationLocations.randomElement()
    }
    
    func updateViews(withVacation vacation: VacationLocation?) {
        vacationNameLabel.text = vacation?.name
        departureDateLabel.text = vacation?.departureDateString
        vacationImageView.image = vacation?.image
    }
}

