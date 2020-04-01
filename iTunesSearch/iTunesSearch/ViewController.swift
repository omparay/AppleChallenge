//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Oliver Paray on 4/1/20.
//  Copyright © 2020 Oliver Paray. All rights reserved.
//

import Library
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var searchInstructionsLabel: UILabel!
    @IBOutlet weak var criteriaField: UITextField!
    @IBOutlet weak var resultsInstructionLabel: UILabel!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchActivity: UIActivityIndicatorView!

    //Properties
    private var alert: UIAlertController = UIAlertController(title: "Alert", message: String.empty, preferredStyle: .alert)
    private var results: JSON?
    private var summarized = [String:JSON]()
    private var hasResults: Bool {
        get {
            if self.results != nil {
                return true
            } else {
                self.displayError(withTitle: "Error...", andMessage: "No results to display.")
                return false
            }
        }
    }

    //View Lifecycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChanged(sender:)), name: UITextField.textDidChangeNotification, object: self.criteriaField)
    }

    //Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return summarized.allKeys.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: summarized.allKeys[section])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        return cell
    }

    //Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Mark this as a favorite...
    }

    //Notification Handlers
    @objc func handleTextChanged(sender: NSNotification){
        guard let field = sender.object as? UITextField, let text = field.text else { return }
        debugPrint("Search Text: \(text)")
        searchAnimation()
        iTunesSearch.performSearch(withTerm: text, handler: (
            success: {
                (httpResponse, httpData) in
                guard let response = httpResponse as? HTTPURLResponse, let data = httpData else {
                    self.displayError()
                    return
                }
                if response.statusCode != 200 {
                    self.displayError(withTitle: "HTTP Error...", andMessage: "No Internet Connection?\nTyu again later...")
                }
                self.processResult(data)
            },
            failure: {
                (httpResponse,systemError,errorMessage) in
                guard let message = errorMessage else {
                    self.displayError()
                    return
                }
                self.displayError(withTitle: "Error...", andMessage: message)
            })
        )
    }

    //Private Methods
    private func searchAnimation(_ start: Bool=true){
        DispatchQueue.main.async {
            self.searchActivity.isHidden = !start
            if start {
                self.searchActivity.startAnimating()
            } else {
                self.searchActivity.stopAnimating()
            }
        }
    }

    private func processResult(_ data:Data){
        guard let jsonData = Parser.jsonFrom(data: data) else {
            self.displayError()
            return
        }
        self.results = jsonData
        DispatchQueue.main.async {
            self.searchAnimation(false)
            //Process and display results
        }
    }

    private func displayError(withTitle: String = "Ooops...",
                              andMessage:String = "Something weird has happened.\nPlease try again."){
        DispatchQueue.main.async {
            self.alert = UIAlertController(title: withTitle, message: andMessage, preferredStyle: .alert)
            self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.alert.dismiss(animated: true, completion: nil)
            }))
            self.searchAnimation(false)
            self.present(self.alert, animated: true, completion: nil)
        }
    }

}
