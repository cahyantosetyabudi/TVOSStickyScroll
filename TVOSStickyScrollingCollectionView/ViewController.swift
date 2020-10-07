//
//  ViewController.swift
//  TVOSStickyScrollingCollectionView
//
//  Created by Cahyanto Setya Budi on 07/10/20.
//  Copyright © 2020 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    private func setupView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let pindex  = context.previouslyFocusedIndexPath, let cell = collectionView.cellForItem(at: pindex) {
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.shadowRadius = 0.0
            cell.contentView.layer.shadowOpacity = 0.0
        }
        
        if let index  = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: index) {
            cell.contentView.layer.borderWidth = 8.0
            cell.contentView.layer.borderColor = UIColor.orange.cgColor
            cell.contentView.layer.shadowColor = UIColor.orange.cgColor
            cell.contentView.layer.shadowRadius = 10.0
            cell.contentView.layer.shadowOpacity = 0.9
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let focusView = context.nextFocusedView as? CollectionViewCell, let indexPath = collectionView.indexPath(for: focusView) {
            collectionView.isScrollEnabled = false
            coordinator.addCoordinatedAnimations({
                self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            }, completion: nil)
        }
    }
}
