//
//  ShowTableViewCell.swift
//  m4ttMicroB
//
//  Created by Mac on 19.11.2022.
//

import UIKit
import RealmSwift

protocol LikeUnlikeDelegate {
    func didTapLike()
}

class ShowTableViewCell: UITableViewCell {
    
    
    let storage = Storage.shared
    private var isLiked = false
    var delegate: LikeUnlikeDelegate!
    
    //MARK: - Outlets:
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var likeOutlet: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - setup CELL:
    
    func setupCells(nameLabel: String,
                    genresLabel: String,
                    ratingLabel: String,
                    id: Int,
                    indexPath: IndexPath) {
        // peredat like?
        self.likeOutlet.tag = indexPath.row
        self.likeOutlet.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        self.nameLabel.text = nameLabel
        self.genresLabel.text = genresLabel
        self.ratingLabel.text = ratingLabel
    }
    
    func setupCellForFavorite(nameLabel: String,
                              genresLabel: String,
                              ratingLabel: String) {
        
        self.likeOutlet.addTarget(self, action: #selector(dislikePressed), for: .touchUpInside)
        self.nameLabel.text = nameLabel
        self.genresLabel.text = genresLabel
        self.ratingLabel.text = ratingLabel
    }
    
    private func flipLikedState() {
        isLiked = !isLiked
        animate()
    }
    
    private func animate() {
        let unlikedShow = UIImage(named: "appUnlike")
        let likedShow = UIImage(named: "appLike")
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? likedShow : unlikedShow
            self.transform = self.transform.scaledBy(x: 0.8, y: 0.8)
            self.likeOutlet.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
    
    
    @objc func likePressed(sender: UIButton) {
        let items = FavoritesModel()
        items.nameLabel = nameLabel.text!
        items.genresLabel = genresLabel.text!
        items.ratingLabel = ratingLabel.text!
        items.id = likeOutlet.tag
        storage.save(items)
        flipLikedState()
        
        
        
    }
    
    @objc func dislikePressed(sender: UIButton) {
        flipLikedState()
        storage.remove(sender.tag)
        delegate.didTapLike()
    }
    
}


