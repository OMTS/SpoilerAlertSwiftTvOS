//
//  HomeViewController.swift
//  SpoilerAlertSwiftTvOS
//
//  Created by Florian Pygmalion on 19/12/2016.
//  Copyright © 2016 One More Thing Studio. All rights reserved.
//

import UIKit
import Model
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    var timer: Timer?
    var series: [Serie]? {
        didSet {
            guard let series = series, !series.isEmpty else { return }
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getAllSeries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            let listVisibleCells = self.collectionView.visibleCells
            for cell in listVisibleCells {
                guard let serieCell = cell as? SerieCollectionViewCell else { return }
                let calendar = Calendar.current
                if let maxDate = calendar.date(byAdding: .day, value: 3, to: serieCell.serie.date) {
                    let timeLeft = maxDate.timeIntervalSinceNow
                    serieCell.statusSpoilLabel.text = timeLeft > 0 ? "\(timeLeft.time)" : "On peut spoiler"

//                    serieCell.statusSpoilLabel.text = timeLeft < 0 ? "on peut spoile" : "on peut pas spoile"
                }
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    func getAllSeries() {
        Serie.getAllSeries(completionHandler: { (series, error) in
            if let error = error {
                print(error)
            } else if let series = series {
                self.series = series
            }
        })
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        if sender == reloadButton {
        }
    }

}

// MARK: UICollectionView Delegate, DelegateFlowLayout, DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieCollectionViewCell", for: indexPath) as! SerieCollectionViewCell
        let serie = series![indexPath.row]
        cell.serie = serie

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 20) * 0.5
        let height = (view.frame.size.height - 150 - 20) * 0.5
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension TimeInterval {

    var time: String {
        var interval = Int(self)
        let day = interval / (3600 * 24)
        interval = interval % (3600 * 24)
        let hours = interval / 3600
        let minutes = (interval / 60) % 60
        let seconds = interval % 60

        return String(format: "%02d Jour %02d:%02d:%02d", day, hours, minutes, seconds)
    }
    
}
