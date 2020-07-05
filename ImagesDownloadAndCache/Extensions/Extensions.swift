//
//  Extensions.swift
//  ImagesDownloadAndCache
//
//  Created by Bhavin Gupta on 03/07/20.
//  Copyright © 2020 Bhavin Gupta. All rights reserved.
//

import UIKit

enum ConstraintType {
  case top, leading, trailing, bottom, width, height
}

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
    //translate the view's autoresizing mask into Auto Layout constraints
    translatesAutoresizingMaskIntoConstraints = false
    
    var constraints: [ConstraintType : NSLayoutConstraint] = [:]
    
    if let top = top {
      constraints[.top] = topAnchor.constraint(equalTo: top, constant: padding.top)
    }
    
    if let leading = leading {
      constraints[.leading] = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
    }
    
    if let bottom = bottom {
      constraints[.bottom] = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
    }
    
    if let trailing = trailing {
      constraints[.trailing] = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
    }
    
    if size.width != 0 {
      constraints[.width] = widthAnchor.constraint(equalToConstant: size.width)
    }
    
    if size.height != 0 {
      constraints[.height] = heightAnchor.constraint(equalToConstant: size.height)
    }
    let constraintsArray = Array<NSLayoutConstraint>(constraints.values)
    NSLayoutConstraint.activate(constraintsArray)
  }
  
  func height(constant: CGFloat) {
    setConstraint(value: constant, attribute: .height)
  }
  
  func width(constant: CGFloat) {
    setConstraint(value: constant, attribute: .width)
  }
  
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
    constraints.forEach {
      if $0.firstAttribute == attribute {
        removeConstraint($0)
      }
    }
  }
  
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
    removeConstraint(attribute: attribute)
    let constraint =
      NSLayoutConstraint(item: self,
                         attribute: attribute,
                         relatedBy: NSLayoutConstraint.Relation.equal,
                         toItem: nil,
                         attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                         multiplier: 1,
                         constant: value)
    self.addConstraint(constraint)
  }
}
