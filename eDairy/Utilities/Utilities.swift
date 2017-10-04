//
//  Utilities.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

func animateBorderWidth(view: UIView, from: CGFloat, to: CGFloat, duration: Double) {
    let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
    animation.fromValue = from
    animation.toValue = to
    animation.duration = duration
    animation.autoreverses = false
    view.layer.add(animation, forKey: "Width")
    view.layer.borderWidth = to
}
