/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A `UICollectionViewCell` subclass used to display an `IceCream` in the `IceCreamsViewController`.
*/

import UIKit
import Messages

class IceCreamCell: UICollectionViewCell {
    
    static let reuseIdentifier = "IceCreamCell"
    
    var representedIceCream: IceCream?
    var selectGame: (() -> Void)?
    @IBOutlet weak var sticker: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBAction func gameSelected(_ sender: UIButton) {
        selectGame?()
    }
}
