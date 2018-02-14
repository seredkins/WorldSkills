//
//  AddNewsViewController.swift
//  DigitalSkills
//
//  Created by theSERG on 10/02/2018.
//  Copyright © 2018 seredkins. All rights reserved.
//

import UIKit

class AddNewsViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView! {
        didSet {
            titleTextView.text = ""
        }
    }
    
    @IBOutlet weak var bodyTextView: UITextView! {
        didSet {
            bodyTextView.text = "" 
        }
    }
    
    @IBAction func addNews(_ sender: UIButton) {
        guard titleTextView.text != nil,
            bodyTextView.text != nil else { return }
        
        performSegue(withIdentifier: "addNewsSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newsVC = segue.destination as? NewsTableViewController,
            segue.identifier == "addNewsSegue" else { return }
        
        newsVC.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        let newNewsCell = newsVC.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        newNewsCell?.textLabel?.text = titleTextView.text
        
        newsVC.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
