//
//  Extensions.swift
//  DrawingApp
//
//  Created by Giulia Ariu on 19/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

//MARK:- UICOLOR
extension UIColor {
  
  class func stringFromColor(color: UIColor) -> String {
    
    let components = color.cgColor.components
    
    // Forcing because black and white have only 2 components
    if color == UIColor.white || color == UIColor.black || color == UIColor.darkGray {
      return "[\(components![0]), \(components![1])]"
    }
    
    return "[\(components![0]), \(components![1]), \(components![2]), \(components![3])]"
  }
  
  class func colorFromString(string: String) -> UIColor {
    
    let componentsString = (string.replacingOccurrences(of: "[", with: "")).replacingOccurrences(of: "]", with: "")
    let components = componentsString.components(separatedBy: ", ")
    
    // If there're only two color components it means that is Black or White or DarkGrey
    if components.count == 2 {
      // Forcing because black and white have only 2 components
      if components[0] == 1.0.description && components[1] == 1.0.description {
        return UIColor.white
      }
      if components[0] == 0.0.description && components[1] == 1.0.description {
        return UIColor.black
      }
      if components[0] == 0.3333333333333333.description && components[1] == 1.0.description {
        return UIColor.darkGray
      }
    }
    
    // If there are more then 2 components return every component
    return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                   green: CGFloat((components[1] as NSString).floatValue),
                   blue: CGFloat((components[2] as NSString).floatValue),
                   alpha: CGFloat((components[3] as NSString).floatValue))
  }
  
}

//MARK:- UIVIEW
extension UIView {
  
  func takeScreenshot() -> UIImage {
    
    // Begin context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
    
    // Draw view in that context
    drawHierarchy(in: self.bounds, afterScreenUpdates: true)
    
    // And finally, get image
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    if (image != nil) {
      return image!
    }
    return UIImage()
  }
}


extension UIFont {
    
    /**
     Will return the best font conforming to the descriptor which will fit in the provided bounds.
     */
  static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
        let constrainingDimension = min(bounds.width, bounds.height)
        let properBounds = CGRect(origin: .zero, size: bounds.size)
        var attributes = additionalAttributes ?? [:]
        
        let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
        var bestFontSize: CGFloat = constrainingDimension
        
        for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
            let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
            attributes[.font] = newFont
            
            let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
            
            if properBounds.contains(currentFrame) {
                bestFontSize = fontSize
                break
            }
        }
        return bestFontSize
    }
    
  static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
        let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
        return UIFont(descriptor: fontDescriptor, size: bestSize)
    }
}



extension UILabel {
    
    /// Will auto resize the contained text to a font size which fits the frames bounds.
    /// Uses the pre-set font to dynamically determine the proper sizing
    func fitTextToBounds() {
        guard let text = text, let currentFont = font else { return }
    
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
        font = bestFittingFont
    }
    
  private var basicStringAttributes: [NSAttributedString.Key: Any] {
    var attribs = [NSAttributedString.Key: Any]()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode
        attribs[.paragraphStyle] = paragraphStyle
        
        return attribs
    }
}
