//
//  ViewController.swift
//  DigitalSkills
//
//  Created by theSERG on 10/02/2018.
//  Copyright © 2018 seredkins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func tryLogin(_ sender: UIButton) {
        guard let login = loginTextField.text,
            let password = passwordTextField.text else { return }
        
        // Request to Firebase
        
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let newsTableVC = segue.destination as? NewsTableViewController else { return }
//        // Setting up newsTableVC
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

