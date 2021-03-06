//
//  ViewController.swift
//  AppForAnthony
//
//  Created by Carlos Carrillo on 8/23/17.
//  Copyright © 2017 Carlos Carrillo. All rights reserved.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myTextField: UITextField!
    
    // Delagate connection variable
    lazy var firstViewModel:ViewModel1 = ViewModel1(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        firstViewModel.triggerDisplayInfo()
    }
    
    // Download images and pass # of pokemons downloaded
    @IBAction func inputButton(sender: UIButton){
        guard let text = myTextField.text else {return}
        guard let userInput = Int(text) else {return}
        firstViewModel.getImage(pokeNumber: userInput)
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        myVC.passedIndex = userInput
        navigationController?.pushViewController(myVC, animated: true)
        print("@IBAction")
    }
    
    // Just background pic (cosmetics)
    func setBackgroundImage(){
        let background = UIImage(named: "pokeBack")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Load all the views.
extension FirstViewController:VMDelegate1 {
    func getPokemonNames(string: String) {
        DispatchQueue.main.async {
            // Cosmetic settings for elements
            self.myTextField.delegate = self
            self.myLabel.layer.cornerRadius = 10.0
            self.myLabel.clipsToBounds = true
            self.myButton.layer.cornerRadius = 15
            self.myButton.clipsToBounds = true
            self.myTextField.layer.cornerRadius = 15
            self.myTextField.clipsToBounds = true
        }
    }
}

// Input Validation
extension FirstViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}







