//
//  TableViewController.swift
//  AppForAnthony
//
//  Created by Carlos Carrillo on 8/23/17.
//  Copyright © 2017 Carlos Carrillo. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    
    var passedIndex:Int?
    var indexToPass:Int?
    var urlToPass:String?
    
    // Delagate connection variable
    lazy var secondViewModel:ViewModel2 = ViewModel2(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let index = passedIndex else {return}
        secondViewModel.getPokemons(inputValue: index)
        let bundle = Bundle(for: CustomTableViewCell.self)
        let nib = UINib(nibName: "CustomeViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "CustomCell")
    }
    
    // Load the table every single time you get to this tab
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondViewModel.getCounter()
    }
    
    // Get Pokemon name and image for each view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        let name = secondViewModel.getName(index: indexPath.row)
        DispatchQueue.main.async {
            let image = self.secondViewModel.getImage(urlIndex: indexPath.row)
            cell.fillCell(with: name, image: image)
        }
        return cell
    }
    
    // Select variables to pass
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        urlToPass = secondViewModel.getUrl(index: indexPath.row)
        indexToPass = indexPath.row
        performSegue(withIdentifier: "mySegue", sender: self)
    }
    
    // Initialize new view controller and select viewController target
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mySegue") {
            let viewController = segue.destination as! ThirdViewController
            viewController.passedUrl = urlToPass
            viewController.passedIndex = indexToPass
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SecondViewController:VMDelegate2{
    func updateTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


