//
//  MovieRegisterViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 18/02/19.
//  Copyright © 2019 Rphmelo. All rights reserved.
//

import UIKit
import CoreData

class MovieRegisterViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tfCategories: UITextField!
    @IBOutlet weak var tvSummary: UITextView!
    
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var ivPoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            tfTitle.text = movie.title
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tfCategories.text = movie.categories
            tvSummary.text = movie.summary
            ivPoster.image = movie.image as? UIImage
            btAddEdit.setTitle("Alterar", for: .normal)
            
        }
    }
    
    @IBAction func addEditMovie(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        movie?.title = tfTitle.text
        movie?.rating = Double(tfRating.text!) ?? 0
        movie?.categories = tfCategories.text
        movie?.duration = tfDuration.text
        movie?.summary = tvSummary.text
        movie?.image = ivPoster.image
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            
        }
        
    }
    
    func selectPicture(source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectPoster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar pôster", message: "De onde você quer escolher o pôster?", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
            self.selectPicture(source: .camera)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default) { (_) in
            self.selectPicture(source: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in
            
        }
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension MovieRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            ivPoster.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
