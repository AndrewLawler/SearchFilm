//
//  FavouritesViewController.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import CoreData

struct filmCell {
    var filmName: String?
    var filmPoster: String?
    var filmGenre: String?
    var filmRating: String?
    var filmYear: String?
}

class FavouritesViewController: UIViewController {
    
    // elements
    var films: [NSManagedObject] = []
    var tableFilms: [filmCell] = []
    let tableView = UITableView()
    let informationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearArrays()
        coreReload()
    }
    
    func clearArrays() {
        films = []
        tableFilms = []
    }
    
    func coreReload(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                films.append(data)
                tableFilms.append(filmCell(filmName: data.value(forKey: "filmName") as? String, filmPoster: data.value(forKey: "filmPoster") as? String, filmGenre: data.value(forKey: "filmGenre") as? String, filmRating: data.value(forKey: "filmRating") as? String, filmYear: data.value(forKey: "filmYear") as? String))
            }
        } catch {
            print("Failed")
        }
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func configureUI() {
        // configure our elements and constrain them
        configureTableView()
        configureLabel()
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            informationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            informationLabel.widthAnchor.constraint(equalToConstant: view.frame.width-60),
            informationLabel.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
    }

    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.rowHeight = 120
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilmCell.self, forCellReuseIdentifier: "myCell")
    }
    
    func configureLabel() {
        view.addSubview(informationLabel)
        
        informationLabel.text = "If there’s a film you no-longer wish to store, swipe it away and it will be deleted."
        informationLabel.font = UIFont(name: "Helvetica", size: 15)
        informationLabel.numberOfLines = 0
        informationLabel.textAlignment = .center
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.textColor = .systemGray
    }
    
    func configView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Film Shelf"
        view.backgroundColor = .white
        customiseStatusBar()
    }
    
    // customise status bar
    func customiseStatusBar() {
        
        let app = UIApplication.shared
        let statusBarHeight: CGFloat = app.statusBarFrame.size.height
        
        let statusbarView = UIView()
        statusbarView.backgroundColor = .filmColour
        view.addSubview(statusbarView)
        
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        statusbarView.heightAnchor
            .constraint(equalToConstant: statusBarHeight).isActive = true
        statusbarView.widthAnchor
            .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        statusbarView.topAnchor
            .constraint(equalTo: view.topAnchor).isActive = true
        statusbarView.centerXAnchor
              .constraint(equalTo: view.centerXAnchor).isActive = true
    }
    

}

// add mockup cells
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FilmCell
        cell.update(image: tableFilms[indexPath.row].filmPoster!, name: tableFilms[indexPath.row].filmName!, rating: tableFilms[indexPath.row].filmRating!, genre: tableFilms[indexPath.row].filmGenre!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            tableView.beginUpdates()
            tableFilms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
            context.delete(films[indexPath.row])
            do
            {
            try context.save()
            } catch {
                print("changes failed")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = ViewFilmViewController()
        destVC.filmToSearch = tableFilms[indexPath.row].filmName
        if (tableFilms[indexPath.row].filmYear != "") {
            destVC.yearToSearch = tableFilms[indexPath.row].filmYear
        }
        else {
            destVC.yearToSearch = ""
        }
        let navController = UINavigationController(rootViewController: destVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.barTintColor = .filmColour
        present(navController, animated: true)
    }
    
    
}

