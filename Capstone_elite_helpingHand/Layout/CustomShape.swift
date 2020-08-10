//
//  CustomShape.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomShape : Shape {
      
      var corner : UIRectCorner
      var radii : CGFloat
      
      func path(in rect: CGRect) -> Path {
          
          let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
          
          return Path(path.cgPath)
      }
  }
