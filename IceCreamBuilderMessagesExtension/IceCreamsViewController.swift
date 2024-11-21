/*
See the LICENSE.txt file for this sample’s licensing information.
*/

import UIKit


class IceCreamsViewController: UICollectionViewController {
    
    /// An enumeration that represents an item in the collection view.
    
    enum CollectionViewItem {
        case iceCream(IceCream)
        case create
    }
    
    static let storyboardIdentifier = "IceCreamsViewController"
    
    weak var delegate: IceCreamsViewControllerDelegate?
    
    private let items: [Game]
    
    private let stickerCache = IceCreamStickerCache.cache
    
    required init?(coder aDecoder: NSCoder) {
        
        let items: [Game] = [
            Game(sticker: UIImage(named: "openart-memory-sticker")!, name: "Memory", comingSoon: false),
            /*Game(sticker: UIImage(named: "openart-madlibs-sticker")!, name: "MadLibs", comingSoon: true)*/
        ]
        
        self.items = items
        super.init(coder: aDecoder)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    private func navigateToMemoryScreen(for game: Game) {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let lessonsVC = storyboard.instantiateViewController(withIdentifier: "LessonsViewController") as? LessonsViewController else {
            fatalError("Controllers not found")
        }
        self.present(lessonsVC, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IceCreamCell.reuseIdentifier, for: indexPath) as! IceCreamCell
        let item = items[indexPath.item]
        
        // Configure the cell
        cell.sticker.image = item.sticker
        cell.name.text = item.name
        cell.selectGame = { [weak self] in
            self?.navigateToMemoryScreen(for: item)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
    }
    
    private func dequeueIceCreamCell(for iceCream: IceCream, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: IceCreamCell.reuseIdentifier, for: indexPath) as? IceCreamCell
        else { fatalError("Unable to dequeue am IceCreamCell") }
        
        cell.representedIceCream = iceCream
        
        return cell
    }
}

protocol IceCreamsViewControllerDelegate: AnyObject {

    /// Called when a user choses to add a new `IceCream` in the `IceCreamsViewController`.

    func iceCreamsViewControllerDidSelectAdd(_ controller: IceCreamsViewController)
}
