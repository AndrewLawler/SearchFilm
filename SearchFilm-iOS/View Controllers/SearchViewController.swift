//
//  SearchViewController.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // elements
    let appLogo = UIImageView()
    let filmNameInput = FilmTextField(place: "Film Name")
    let filmYearInput = FilmTextField(place: "Film Year")
    let goButton = FilmButton(bgColour: .filmColour, title: "Go", titleColour: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configureUI()
    }
    
    func configView() {
        // hide nav
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
    }
    
    func configureUI() {
        
        // configure elements and constrain them
        
        appLogo.image = UIImage(named: "Logo")
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        goButton.addTarget(self, action: #selector(searchForFilm), for: .touchUpInside)
        
        filmYearInput.delegate = self
        filmNameInput.delegate = self
        
        view.addSubview(filmNameInput)
        view.addSubview(filmYearInput)
        view.addSubview(goButton)
        view.addSubview(appLogo)
        
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            appLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogo.heightAnchor.constraint(equalToConstant: (view.frame.height/2)+15),
            appLogo.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            filmNameInput.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 20),
            filmNameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmNameInput.heightAnchor.constraint(equalToConstant: 50),
            filmNameInput.widthAnchor.constraint(equalToConstant: view.frame.width-100),
            
            filmYearInput.topAnchor.constraint(equalTo: filmNameInput.bottomAnchor, constant: 20),
            filmYearInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmYearInput.heightAnchor.constraint(equalToConstant: 50),
            filmYearInput.widthAnchor.constraint(equalToConstant: view.frame.width-100),
            
            goButton.topAnchor.constraint(equalTo: filmYearInput.bottomAnchor, constant: 40),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.heightAnchor.constraint(equalToConstant: 40),
            goButton.widthAnchor.constraint(equalToConstant: 160),
        ])
        
    }
    
    @objc func searchForFilm() {
        // present new view
        
        if (filmNameInput.text == "") {
            presentAlertOnMainThread(title: "Enter Something", message: "Please Enter some text into the inputs!", buttonTitle: "Ok")
        }
        else {
            let destVC = ViewFilmViewController()
            destVC.filmToSearch = filmNameInput.text
            destVC.yearToSearch = filmYearInput.text
            let navController = UINavigationController(rootViewController: destVC)
            navController.navigationBar.prefersLargeTitles = true
            navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navController.navigationBar.barTintColor = .filmColour
            present(navController, animated: true)
        }
    }

}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        filmNameInput.text = ""
        filmYearInput.text = ""
        return true
    }
    
}

