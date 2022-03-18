//
//  ViewController.swift
//  CoreDataPlayground
//
//  Created by Giovanni Madalozzo on 16/03/22.


import UIKit

class ViewController: UIViewController {
    let coredata = CoreDataManager()

    @IBOutlet weak var textField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonCreate(_ sender: UIButton) {
        textField.text = coredata.createData()
    }
    
    @IBAction func buttonDelete(_ sender: UIButton) {
        textField.text = coredata.deleteData()
    }
    @IBAction func buttonQueryPlayer(_ sender: UIButton) {
        textField.text = coredata.allPlayers()
    }
    @IBAction func buttonQueryTeam(_ sender: UIButton) {
        textField.text = coredata.allTeams()
    }
}

