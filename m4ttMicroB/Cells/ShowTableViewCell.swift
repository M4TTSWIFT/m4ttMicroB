//
//  ShowTableViewCell.swift
//  m4ttMicroB
//
//  Created by Mac on 19.11.2022.
//

import UIKit

protocol ShowTableViewCellDelegate: AnyObject {
    func didTapButton(_ tag: Int)
}

class ShowTableViewCell: UITableViewCell {
    
    var delegate:  ShowTableViewCellDelegate?
    
    //MARK: - Outlets:
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - IBActions:
    
    @IBAction func didTapButton(_ sender: UIButton) {
        delegate?.didTapButton(sender.tag)
        
    }
    
    func setupCells(nameLabel: String, genresLabel: String, ratingLabel: String) {
        self.nameLabel.text = nameLabel
        self.genresLabel.text = genresLabel
        self.ratingLabel.text = ratingLabel
    }
    

}
    

