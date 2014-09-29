//
//  UIColorWDUtils.swift
//
//  Created by Walter Da Col on 28/09/14.
//  Copyright (c) 2014 Walter Da Col. All rights reserved.
//

import UIKit

/**
Returns the color components of the provided color hex value.

:param: rgba an RGBA Hex value (0x00000000).

:returns: A tuple of intensity values for the color components (including alpha) associated with the specified color.
*/
func WDDecomposeRGBA(rgba: UInt) -> (CGFloat, CGFloat, CGFloat, CGFloat){
    let sRgba = min(rgba,0xFFFFFFFF)
    let red: CGFloat = CGFloat((sRgba & 0xFF000000) >> 24) / 255.0
    let green: CGFloat = CGFloat((sRgba & 0x00FF0000) >> 16) / 255.0
    let blue: CGFloat = CGFloat((sRgba & 0x0000FF00) >> 8) / 255.0
    let alpha: CGFloat = CGFloat(sRgba & 0x000000FF) / 255.0
    
    return (red,green,blue,alpha)
}

/**
Returns the color components of the provided color hex value.

:param: rgb an RGB Hex value (0x000000).

:returns: A tuple of intensity values for the color components (including alpha) associated with the specified color.
*/
func WDDecomposeRGB(rgb: UInt) -> (CGFloat, CGFloat, CGFloat, CGFloat){
    return WDDecomposeRGBA(rgb << 8 + 255)
}

/**
Returns the RGBA hex value of the provided 8bit color components (including opacity as float value).

:param: red   The red component of the color object, specified as a value from 0 to 255.
:param: green The green component of the color object, specified as a value from 0 to 255.
:param: blue  The blue component of the color object, specified as a value from 0 to 255.
:param: alpha The opacity value of the color object, specified as a value from 0.0 to 1.0.

:returns: A RGBA value for the specified color components.
*/
func WDCompose8bitRGBA(red:UInt, green:UInt, blue:UInt, alpha: Float) -> UInt {
    let sRed = min(255, red)
    let sGreen = min(255, green)
    let sBlue = min(255, blue)
    let sAlpha = min(1.0, max(0.0, alpha))
    return (sRed << 24) + (sGreen << 16) + (sBlue << 8) + UInt(sAlpha * 255)
}

/**
Returns the RGBA hex value of the provided 8bit color components (opacity defaults to 1.0).

:param: red   The red component of the color object, specified as a value from 0 to 255.
:param: green The green component of the color object, specified as a value from 0 to 255.
:param: blue  The blue component of the color object, specified as a value from 0 to 255.

:returns: A RGBA value for the specified color components.
*/
func WDCompose8bitRGBA(red:UInt, green:UInt, blue:UInt) -> UInt{
    return WDCompose8bitRGBA(red, green, blue, 1.0)
}

/**
*  This extension adds some common utilities to UIColor
*/
extension UIColor {
    /**
    Initializes and returns a color object using the specified RGBA hex code.
    
    :param: rgba The RGBA hex value.
    
    :returns: An initialized color object.
    */
    convenience init(rgba: UInt){
        let (red,green,blue,alpha) = WDDecomposeRGBA(rgba)
        
        self.init(red: red, green: green, blue:blue, alpha:alpha)
    }
    
    /**
    Initializes and returns a color object using the specified RGB hex code, opacity defaults to 1.0.
    
    :param: rgb The RGB hex value.
    
    :returns: An initialized color object.
    */
    convenience init(rgb: UInt){
        self.init(rgba: rgb << 8 + 255)
    }
    
    /**
    Initializes and returns a color object using the specified white amount and RGBA hex value, useful to create color tints.
    
    :param: rgba        The RGBA hex value.
    :param: whiteAmount The white amount, specified as a value from 0.0 to 1.0.
    
    :returns: An initialized color object.
    */
    convenience init(rgba: UInt, whiteAmount:Float){
        let x = CGFloat(min(1.0, max(0.0, whiteAmount)))
        
        let (red, green, blue, alpha) = WDDecomposeRGBA(rgba)
        
        self.init(red: min(red + x,1.0), green: min(green + x,1.0), blue:min(blue + x,1.0), alpha:alpha)
        
    }
    
    /**
    Initializes and returns a color object using the specified white amount and RGB hex value, useful to create color tints.
    
    :param: rgb         The RGB hex value.
    :param: whiteAmount The white amount, specified as a value from 0.0 to 1.0.
    
    :returns: An initialized color object.
    */
    convenience init(rgb: UInt, whiteAmount:Float){
        self.init(rgba:(rgb << 8 + 255), whiteAmount: whiteAmount)
    }
    
    /**
    Initializes and returns a color object using the specified black amount and RGBA hex value, useful to create color shades.
    
    :param: rgba        The RGBA hex value.
    :param: blackAmount The black amount, specified as a value from 0.0 to 1.0.
    
    :returns: An initialized color object.
    */
    convenience init(rgba: UInt, blackAmount:Float){
        let x = CGFloat(min(1.0, max(0.0, blackAmount)))
        
        let (red, green, blue, alpha) = WDDecomposeRGBA(rgba)
        
        self.init(red: max(red - x, 0.0), green: max(green - x, 0.0), blue:max(blue - x, 0.0), alpha:alpha)
    }
    
    /**
    Initializes and returns a color object using the specified black amount and RGB hex value, useful to create color shades.
    
    :param: rgb        The RGB hex value.
    :param: blackAmount The black amount, specified as a value from 0.0 to 1.0.
    
    :returns: An initialized color object.
    */
    convenience init(rgb: UInt, blackAmount:Float){
        self.init(rgba:(rgb << 8 + 255), blackAmount: blackAmount)
    }
    
    /**
    Initializes and returns a color object using the specified opacity and RGB component 8bit values.
    
    :param: red8Bit   The red component of the color object, specified as a value from 0 to 255.
    :param: green8Bit The green component of the color object, specified as a value from 0 to 255.
    :param: blue8Bit  The blue component of the color object, specified as a value from 0 to 255.
    :param: alpha     The opacity value of the color object, specified as a value from 0.0 to 1.0.
    
    :returns: An initialized color object.
    */
    convenience init(red8Bit: UInt, green8Bit:UInt, blue8Bit:UInt, alpha:Float){
        let sRed = CGFloat(min(255, red8Bit)) / 255.0
        let sGreen = CGFloat(min(255, green8Bit)) / 255.0
        let sBlue = CGFloat(min(255, blue8Bit)) / 255.0
        let sAlpha = CGFloat(min(1.0, max(0.0, alpha)))
        self.init(red: sRed, green: sGreen, blue: sBlue, alpha: sAlpha)
    }
    
    /**
    Calculates the RGBA hex value of the receiver.
    
    :returns: The RGBA hex value or nil if this color can't be associated with RGBA components.
    */
    func toRGBA() -> UInt? {
        let colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)).value
        let components =  CGColorGetComponents(self.CGColor)
        
        switch colorSpaceModel {
        case kCGColorSpaceModelRGB.value:
            let (r,g,b,a) = (components[0], components[1], components[2], components[3])
            return WDCompose8bitRGBA(UInt(r * 255), UInt(g*255), UInt(b*255), Float(a))
        case kCGColorSpaceModelMonochrome.value:
            let (c,a) = (components[0], components[1])
            return WDCompose8bitRGBA(UInt(c * 255), UInt(c*255), UInt(c*255), Float(a))
        default:
            return nil
        }
    }
}