//
//  Extension + UIViewController.swift
//  m4ttMicroB
//
//  Created by Mac on 22.11.2022.
//

import UIKit

extension UIViewController: ShowTableViewCellDelegate {

    func didTapButton(_ tag: Int) {
        print("I have pressed a button with ID \(tag)")
        }
}
