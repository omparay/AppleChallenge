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
    private var summarized = [String:[SearchResult]]()

    //View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let archivedItems = unArchive() {
            summarized["Favorites"] = archivedItems
        }
        resultsTableView.reloadData()
    }

    //Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return summarized.allKeys.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: summarized.allKeys[section])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let key = summarized.allKeys[section] as? String, let items = summarized[key] else { return 0 }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        let kindString = String(describing: summarized.allKeys[indexPath.section])
        guard let resultItems = summarized[kindString] else { return cell }
        let resultItem = resultItems[indexPath.row]
        cell.nameField.text = resultItem.name
        cell.genreField.text = resultItem.genre
        cell.urlField.text = resultItem.linkUrl
        cell.imageUrl = resultItem.artworkUrl
        return cell
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
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
        }))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }


    //Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let key = summarized.allKeys[indexPath.section] as? String, let items = summarized[key] else { return }
        let item = items[indexPath.row]
        if summarized.keys.contains("Favorites") {
            if let items = summarized["Favorites"] {
                summarized["Favorites"] = items + [item]
                archive(items: items + [item])
            } else {
                summarized["Favorites"] = [item]
                archive(items: [item])
            }
        } else {
            summarized["Favorites"] = [item]
            archive(items: [item])
        }
        self.resultsTableView.reloadData()
    }

    //Private Methods
    private func archive(items: [SearchResult]){
        let archiveData = items.map {
            $0.encode()
        }
        UserDefaults.standard.setValue(archiveData, forKey: "MarkedFavorites")
        UserDefaults.standard.synchronize()
    }

    private func unArchive() -> [SearchResult]? {
        var results = [SearchResult]()
        guard
            let archived = UserDefaults.standard.value(forKey: "MarkedFavorites") as? [Data]
        else { return nil }
        for item in archived {
            if let decoded = SearchResult(data: item) {
                results.append(decoded)
            }
        }
        return results
    }

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

        var lastFaves: [SearchResult]?

        lastFaves = summarized["Favorites"]

        guard
            let jsonData = Parser.jsonFrom(data: data),
            let rawItems = jsonData[iTunesSearch.ResultKeys.results.rawValue] as? [JSON]
            else {
                self.displayError()
                return
        }

        summarized = [String:[SearchResult]]()

        if let faves = lastFaves {
            summarized["Favorites"] = faves
        }

        for rawItem in rawItems {

            let kind = String(forceCastOrEmpty: rawItem[iTunesSearch.ResultKeys.CommonKeys.kind.rawValue])
            let name = String(forceCastOrEmpty: rawItem[iTunesSearch.ResultKeys.CommonKeys.trackName.rawValue])
            let genre = String(forceCastOrEmpty: rawItem[iTunesSearch.ResultKeys.CommonKeys.primaryGenreName.rawValue])
            let artUrl = String(forceCastOrEmpty: rawItem[iTunesSearch.ResultKeys.CommonKeys.artworkUrl100.rawValue])
            let viewUrl = String(forceCastOrEmpty: rawItem[iTunesSearch.ResultKeys.PreviewableKeys.trackViewUrl.rawValue])

            if let id = rawItem[iTunesSearch.ResultKeys.CommonKeys.trackId.rawValue] as? Int {

                let resultItem = SearchResult(id: id, kind: kind, name: name, artworkUrl: artUrl, genre: genre, linkUrl: viewUrl)

                if summarized.allKeys.contains(where: { (item) -> Bool in return kind == String(describing: item) }){
                    if let kindItems = summarized[kind] {
                        let newItems = kindItems + [resultItem]
                        summarized[kind] = newItems
                    } else {
                        summarized[kind] = [resultItem]
                    }
                } else {
                    summarized[kind] = [resultItem]
                }
            }

        }

        DispatchQueue.main.async {
            self.resultsTableView.reloadData()
            self.searchAnimation(false)
        }
    }

    private func displayError(withTitle: String = "Ooops...", andMessage:String = "Something weird has happened.\nPlease try again."){
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
