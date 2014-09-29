UIColorWDUtils (Swift)
===
This is a simple extension for RGB(A) hex values and UIColor class. Support for RGB and RGBA as numeric values

##Examples

	// Class extension
	
	let emerald = UIColor(rgb:0x2ECC71)
	let darkEmerald = UIColor(rgba: emerald.toRGBA()!, blackAmount: 0.1) 
	let lightEmerald = UIColor(rgba: emerald.toRGBA()!, whiteAmount: 0.1)
	
	let peterRiver = UIColor(red8Bit: 52, green8Bit: 152, blue8Bit: 219, alpha: 1.0)
	
	// Utilities
	let (redComponent, _, _, _) = WDDecomposeRGBA(emerald.toRGBA()!)
	let myColorHexValue = WDCompose8bitRGBA(UInt(redComponent * 255) , 100, 200, 1.0)

##License
This code is distributed under the terms and conditions of the [MIT license](LICENSE). 