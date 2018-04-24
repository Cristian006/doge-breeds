//
//  Utils.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/24/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
}
