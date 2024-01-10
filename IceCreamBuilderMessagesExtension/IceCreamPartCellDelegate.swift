//
//  IceCreamPartCellDelegate.swift
//  IceCreamBuilder
//
//  Created by Gisela K on 11/20/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import UIKit

protocol IceCreamPartCellDelegate: AnyObject {
    func didTapAnswer(in cell: UICollectionViewCell)
}
