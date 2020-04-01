//
//  ResultCell.swift
//  iTunesSearch
//
//  Created by Oliver Paray on 4/1/20.
//  Copyright © 2020 Oliver Paray. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var isFavoriteImage: UIImageView!
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var genreField: UILabel!
    @IBOutlet weak var urlField: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
