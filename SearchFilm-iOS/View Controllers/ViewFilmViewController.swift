//
//  ViewFilmViewController.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import CoreData

// struct for custom cells

struct customRow {
    var imageValue:String
    var textValue:String
}

class ViewFilmViewController: UIViewController {

    // UI elements
    
    let filmPoster = UIImageView()
    let filmBio = FilmLabel()
    let tableView = UITableView()
    let informationLabel = FilmLabel()
    
    // variables
    
    var film: Film!
    var dismiss = false
    var tableViewRows: [customRow] = [customRow(imageValue: "calendar", textValue: "No Year"), customRow(imageValue: "person.crop.circle.badge.exclam", textValue: "No Rating"), customRow(imageValue: "folder", textValue: "No Genre"), customRow(imageValue: "flag", textValue: "No Language")]
    
    // holds data from search view
    
    var filmToSearch:String?
    var yearToSearch:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        configureView()
        getFilm()
    }
    
    func getFilm() {
        
        // use result cases and either create our table or show failure alert
        
        NetworkManager.shared.getFilm(for: filmToSearch!, year: Int(yearToSearch!)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let ourFilm):
                self.film = ourFilm
                DispatchQueue.main.async {
                    self.title = ourFilm.Title
                    self.filmBio.text = ourFilm.Plot
                    let imgURL = URL(string: ourFilm.Poster!)
                    self.filmPoster.load(url: imgURL!)
                    self.tableView.reloadData()
                    self.tableViewRows = [customRow(imageValue: "calendar", textValue: self.film?.Year ?? "No Year"), customRow(imageValue: "person.crop.circle.badge.exclam", textValue: self.film?.Rated ?? "No Rating"), customRow(imageValue: "folder", textValue: self.film?.Genre ?? "No Genre"), customRow(imageValue: "flag", textValue: self.film?.Language ?? "No Language")]
                    self.tableView.reloadData()
                }
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        configureUI()
    }

    func configureView() {
        // nav UI
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        doneButton.tintColor = .white
        navigationItem.leftBarButtonItem = doneButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavourites))
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
        
        view.backgroundColor = .filmColour
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func addToFavourites() {
        coreSave()
        presentAlertOnMainThread(title: "Added To Favourites", message: "You have added \(film.Title ?? "") to your film shelf.", buttonTitle: "Ok")
    }
    
    func coreSave() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        let newMovie = NSManagedObject(entity: entity!, insertInto: context)
        newMovie.setValue(film.Title, forKey: "filmName")
        newMovie.setValue(yearToSearch ?? "", forKey: "filmYear")
        newMovie.setValue(film.Rated, forKey: "filmRating")
        newMovie.setValue(film.Genre, forKey: "filmGenre")
        newMovie.setValue(film.Poster, forKey: "filmPoster")
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
    
    func configureUI() {

        // used nil coalescing to check if the values are there and if not i simply presented a default
        
        view.addSubview(filmPoster)
        view.addSubview(filmBio)

        
        configureTableView()
        
        filmPoster.image = UIImage(named: "Logo")
        
        filmPoster.translatesAutoresizingMaskIntoConstraints = false
        filmPoster.image = UIImage(named: "No Poster")
        
        title = film?.Title ?? "No Title"
        filmBio.text = film?.Plot ?? "Sorry the bio for this film is not available. Please try another film!"
        filmBio.font = UIFont(name: "Helvetica", size: 20)
        filmBio.textColor = .white
        filmBio.textAlignment = .center
        
        informationLabel.text = "Remember, you can add this to your favourites by clicking the little + above"
        informationLabel.font = UIFont(name: "Helvetica", size: 20)
        informationLabel.textColor = .white
        informationLabel.textAlignment = .center
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            filmPoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            filmPoster.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmPoster.heightAnchor.constraint(equalToConstant: 300),
            filmPoster.widthAnchor.constraint(equalToConstant: view.frame.width-200),
            
            filmBio.topAnchor.constraint(equalTo: filmPoster.bottomAnchor, constant: padding),
            filmBio.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmBio.widthAnchor.constraint(equalToConstant: view.frame.width-60),
            filmBio.heightAnchor.constraint(equalToConstant: 90),

            tableView.topAnchor.constraint(equalTo: filmBio.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureTableView() {
        tableView.isHidden = false
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ViewFilmCell.self, forCellReuseIdentifier: "myCell")
        tableView.isHidden = false
    }

}

extension ViewFilmViewController: UITableViewDelegate, UITableViewDataSource {
    
    // used a custom cell, just passed in the system name for the image i wanted each time, used a struct and then array for this
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ViewFilmCell
        cell.update(image: tableViewRows[indexPath.row].imageValue, text: tableViewRows[indexPath.row].textValue)
        return cell
    }
    
    
}
