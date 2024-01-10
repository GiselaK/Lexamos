/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A `UICollectionViewCell` subclass used to display an ice cream part in the `BuildIceCreamViewController`.
*/

import UIKit

class IceCreamPartCell: UICollectionViewCell {
    
    static let reuseIdentifier = "IceCreamPartCell"
    
    @IBOutlet weak var answer: UIButton!

    weak var delegate: IceCreamPartCellDelegate?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.didTapAnswer(in: self)
    }
}
