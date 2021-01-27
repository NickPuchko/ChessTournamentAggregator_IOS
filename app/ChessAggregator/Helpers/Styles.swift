//
// Created by Иван Лизогуб on 21.11.2020.
//

import UIKit

enum Styles {
    enum Color {
        static let appGreen: UIColor = .rgba(50, 160, 97)
        static let tinyGray: UIColor = (UIColor.lightGray).withAlphaComponent(0.1)
        static let fineGray: UIColor = UIColor(white: 0.999, alpha: 1.0)
        static let asteriskRed: UIColor = .rgba(240, 52, 52)
        static let buttonBlue: UIColor = .rgba(0, 122, 255)
        static let redExit: UIColor = .rgba(255, 59, 48)
        static let lightGray: UIColor = .rgba(199, 199, 204)
        static let backgroundGray: UIColor = .rgba(229, 229, 229)
    }

    static func numberToImage(drawText text: String) -> UIImage {
        let textColor = UIColor.systemBlue
        let textFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)!
        let scale = UIScreen.main.scale
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
        let size = (text as NSString).size(withAttributes: textFontAttributes)
        let image = UIColor.white.image(CGSize(width: size.width, height: size.height))

        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: .zero, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
