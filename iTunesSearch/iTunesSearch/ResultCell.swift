//
//  ResultCell.swift
//  iTunesSearch
//
//  Created by Oliver Paray on 4/1/20.
//  Copyright © 2020 Oliver Paray. All rights reserved.
//

import UIKit
import Library

class ResultCell: UITableViewCell {

    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var genreField: UILabel!
    @IBOutlet weak var urlField: UILabel!

    var imageUrl: String? {
        willSet(newValue) {
            if let urlString = newValue, let url = URL(string: urlString) {
                debugPrint("Art Image: \(urlString)")
                HttpClient.sharedInstance.execute(serviceUrl: url, webMethod: Method.Get, executionHandler: (
                    success: { (httpResponse,httpData) in
                        guard let imageData = httpData, let image = UIImage(data: imageData) else { return }
                        DispatchQueue.main.async {
                            self.artworkImage.image = image
                        }
                    },failure: { (httpResponse,systemError,errorMessage) in
                        debugPrint("Error: \(String(describing: errorMessage))")
                    }
                ))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
