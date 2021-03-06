//
//  MarvelHeroCell.swift
//  MarvelApp
//
//  Created by Pamela Ianovalli on 23/02/20.
//  Copyright © 2020 Pamela Ianovalli. All rights reserved.
//

import UIKit

final class MarvelHeroCell: UITableViewCell {
    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    func prepareCell(with hero: Hero) {
        lblName.text = hero.name
        lblDescription.text = hero.description
        
        guard let url = URL(string: hero.thumbnail.url) else { return }
        
        let loader = Loader()
        heroImage.addSubview(loader)
        loader.setup(in: heroImage)
        
        ImageCache.load(url: url) { image in
            DispatchQueue.main.async {
                self.heroImage.image = image
                loader.removeFromSuperview()
            }
        }
        
        heroImage.layer.cornerRadius = heroImage.frame.size.height/2
    }
    
    func reuse() {
        heroImage.image = nil
        lblName.text = nil
        lblDescription.text = nil
    }
}
