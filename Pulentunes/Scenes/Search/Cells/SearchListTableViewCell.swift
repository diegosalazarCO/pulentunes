//
//  SearchListTableViewCell.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/15/19.
//  Copyright © 2019 Diego Alexander Salazar. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func prepareForReuse() {
        coverImageView?.image = #imageLiteral(resourceName: "dafaultAlbum")
        titleLabel?.textColor = .white
        artistLabel?.textColor = .white
    }
    
    func setup(forViewModel viewModel: SearchListViewModel.Item) {
        titleLabel.text = viewModel.title
        artistLabel.text = viewModel.artist
        if let imageUrl = viewModel.coverImage {
            coverImageView.downloadImage(from: imageUrl)
        }
    }
}
