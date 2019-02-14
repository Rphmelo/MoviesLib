//
//  ViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 11/02/19.
//  Copyright © 2019 Rphmelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    func loadMovies(){
        guard let jsonUrl = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            return
        }
        
        do{
            let jsonData = try Data(contentsOf: jsonUrl)
            movies = try JSONDecoder().decode([Movie].self, from: jsonData)
            movies.forEach{(movie) in
                print(movie.title)
            }
        } catch {
            print(error)
        }
        
    }


}

