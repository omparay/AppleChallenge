//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Oliver Paray on 4/1/20.
//  Copyright © 2020 Oliver Paray. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var searchInstructionsLabel: UILabel!
    @IBOutlet weak var criteriaField: UITextField!
    @IBOutlet weak var resultsInstructionLabel: UILabel!
    @IBOutlet weak var resultsTableView: UITableView!

    //View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        return cell
    }

    //Delegates

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return (textField == criteriaField)
    }
}

