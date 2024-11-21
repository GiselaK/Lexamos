/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A `UICollectionViewController` that displays the history of ice creams as well as a cell
 that can be tapped to start the process of creating a new ice cream.
*/

import UIKit


class IceCreamsViewController: UICollectionViewController {

    /// An enumeration that represents an item in the collection view.

    enum CollectionViewItem {
        case iceCream(IceCream)
        case create
    }

    // MARK: Properties
    
    static let storyboardIdentifier = "IceCreamsViewController"
    
    weak var delegate: IceCreamsViewControllerDelegate?

    private let items: [Game]
    
    private let stickerCache = IceCreamStickerCache.cache
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        // Map the previously completed ice creams to an array of `CollectionViewItem`s.
//        let reversedHistory = IceCreamHistory.load().reversed()

        let items: [Game] = [
            Game(sticker: UIImage(named: "openart-memory-sticker")!, name: "Memory", comingSoon: false),
            /*Game(sticker: UIImage(named: "openart-madlibs-sticker")!, name: "MadLibs", comingSoon: true)*/
        ]
        
//        self.items = [
//            Game(image: UIImage(named: "openart-memory-sticker")!, name: "Memory"), Game(image: UIImage(named: "openart-memory-sticker")!, name: "Coming Soon!")
//        ]

        // Add `CollectionViewItem` that the user can tap to start building a new ice cream.
//        items.insert(.create, at: 0)
        
        self.items = items
        super.init(coder: aDecoder)
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    private func navigateToMemoryScreen(for game: Game) {
        // Instantiate the target view controller
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "LessonsViewController") as? LessonsViewController {
            
            // Pass any data if needed
//            detailVC.iceCream = selectedIceCream
            
            // Present the view controller
            self.present(detailVC, animated: true, completion: nil)
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IceCreamCell.reuseIdentifier, for: indexPath) as! IceCreamCell
        // Fetch the corresponding IceCream object
        let item = items[indexPath.item]
        
        // Configure the cell
        cell.sticker.image = item.sticker
        cell.name.text = item.name
        cell.selectGame = { [weak self] in
            self?.navigateToMemoryScreen(for: item)
        }
        
        return cell
        
//        // The item's type determines which type of cell to return.
//        switch item {
//        case .iceCream(let iceCream):
//            return dequeueIceCreamCell(for: iceCream, at: indexPath)
//            
//        case .create:
//            return dequeueIceCreamAddCell(at: indexPath)
//        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
//        switch item {
//        case .create:
//            delegate?.iceCreamsViewControllerDidSelectAdd(self)
//            
//        default:
//            break
//        }
    }
    
    // MARK: Convenience
    
    private func dequeueIceCreamCell(for iceCream: IceCream, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: IceCreamCell.reuseIdentifier, for: indexPath) as? IceCreamCell
            else { fatalError("Unable to dequeue am IceCreamCell") }
        
        cell.representedIceCream = iceCream
        
        // Use a placeholder sticker while we fetch the real one from the cache.
//        let cache = IceCreamStickerCache.cache
//        cell.stickerView.sticker = cache.placeholderSticker
//        
//        // Fetch the sticker for the ice cream from the cache.
//        cache.sticker(for: iceCream) { sticker in
//            OperationQueue.main.addOperation {
//                // If the cell is still showing the same ice cream, update its sticker view.
//                guard cell.representedIceCream == iceCream else { return }
//                cell.stickerView.sticker = sticker
//            }
//        }
        
        return cell
    }
    
//    private func dequeueIceCreamAddCell(at indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: IceCreamAddCell.reuseIdentifier,
//                                                             for: indexPath) as? IceCreamAddCell
//            else { fatalError("Unable to dequeue a IceCreamAddCell") }
//        return cell
//    }
}

// A delegate protocol for the `IceCreamsViewController` class
//private func navigateToMemoryScreen(for game: Game) {
//    let detailViewController = IceCreamDetailViewController(iceCream: iceCream)
//    navigationController?.pushViewController(detailViewController, animated: true)
//}

protocol IceCreamsViewControllerDelegate: AnyObject {

    /// Called when a user choses to add a new `IceCream` in the `IceCreamsViewController`.

    func iceCreamsViewControllerDidSelectAdd(_ controller: IceCreamsViewController)
}
