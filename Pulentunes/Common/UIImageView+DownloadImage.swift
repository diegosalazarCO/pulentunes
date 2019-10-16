//
//  UIImageView+DownloadImage.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/16/19.
//  Copyright © 2019 Diego Alexander Salazar. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
