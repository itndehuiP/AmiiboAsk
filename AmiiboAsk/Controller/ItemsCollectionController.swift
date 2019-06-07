//
//  ItemsCollectionController.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import UIKit
import SDWebImage

class ItemsCollectionController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var popOverView: UIView!
    @IBOutlet weak var textViewInPopOver: UITextView!

    /// It contains the downloaded amiibos
    var dataSourceAmiibos : [ Amiibo] = [ ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissParentVC()
        weak var actInd = self.showActivityIndicatory(uiView: self.view )
        AmiiboApiManager().executeGetAllAmiibos() { (amiibos : [Amiibo ]) in
            self.dataSourceAmiibos = amiibos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                actInd!.stopAnimating()
            }
        }
    }
    ///It closes session
    @IBAction func logtOutTouchUp(_ sender: Any) {
        SessionManager.shared.resetSession()
        performSegue(withIdentifier: "SignOutSegueIdentifier", sender: sender)
    }
    
    /**
     A pop over has been added as an alternative to alert detail, this dismisses the popover
     
     -SeeAlso: `collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)`
 */
    @IBAction func dismissPopOver(_ sender: Any) {
        self.popOverView.removeFromSuperview()
    }
    
    ///It dismisses presenting view controller
    func dismissParentVC() {
        guard let parentCV = self.presentingViewController as? ViewController else { return }
        parentCV.dismiss(animated: false)
    }
    
    /// It creates an activity indicator and add it while the data it´s been loaded
    func showActivityIndicatory( uiView: UIView ) -> UIActivityIndicatorView {
        let actInd = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.style = .gray
        uiView.addSubview(actInd)
        actInd.startAnimating()
        return actInd
    }
}

extension ItemsCollectionController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceAmiibos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellIdentifier", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        let amiibo = dataSourceAmiibos[indexPath.row ]
        ///It downloads the image using SDWebImage Framework
        cell.imagePortrait.sd_setImage(with: URL(string: amiibo.image!), placeholderImage: UIImage(named: "placeholderImge.png"))
        cell.headName.text = amiibo.name
        cell.subheadName.text = amiibo.amiiboSeries
        return cell
    }
    /**It adds a detail view for the selected item
     
     - Remark: Just one of the versions should be implemented
 */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let amiibo = dataSourceAmiibos[indexPath.row ]
//        textViewInPopOver.text = amiibo.description
//        self.view.addSubview(popOverView)
//        popOverView.center = self.view.center
        let detailAlert = UIAlertController(title: amiibo.name!, message: dataSourceAmiibos[indexPath.row].description, preferredStyle: .actionSheet)

        detailAlert.addAction(UIAlertAction(title: "Pew!", style: .default, handler: nil))
        self.present(detailAlert, animated: true)
    }
    
}


extension ItemsCollectionController: UICollectionViewDelegateFlowLayout {
    ///It set the size of the collection view to the size of the device's screen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let width = screenSize.width - 16
        let height = CGFloat(200)
        return CGSize(width: width, height: height)
    }
    
}


