//
//  SerieCollectionViewCell.swift
//  SpoilerAlertSwiftTvOS
//
//  Created by Florian Pygmalion on 19/12/2016.
//  Copyright © 2016 One More Thing Studio. All rights reserved.
//

import UIKit
import Model

class SerieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleSerieLabel: UILabel!
    @IBOutlet weak var subtitleSerieLabel: UILabel!
    @IBOutlet weak var statusSpoilLabel: UILabel!

    var serie: Serie! {
        didSet {
            backgroundImageView.kf.setImage(with: URL(string: serie.image))
            titleSerieLabel.text = serie.name
        }
    }

}
