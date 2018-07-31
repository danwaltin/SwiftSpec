import Cocoa

class Apa {
	
	var items = [String: Any]()
	
	func get(_ key: String) -> Any {
		return items[key]!
	}
	
	func set(_ key: String, _ value: Any) {
		items[key] = value
	}
	
	func getThing<T>(_ key: String) -> T {
		return get(key) as! T
	}
}

struct Thing : CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(stuff)"
	}
	
	let stuff: Int
}

let monkey = Apa()
monkey.set("food", Thing(stuff: 4711))
monkey.get("food")

monkey.set("fun", Thing(stuff: 42))
let t: Thing = monkey.getThing("fun")



class Shape {
	init(color: NSColor) {
		
	}
}

class Rectangle : Shape {
}

let r = Rectangle(color: NSColor.blue)


protocol P {
	subscript(key: String) -> Any? {get set}
}

class Q : P {
	subscript(key: String) -> Any? {
		get {
			return ""
		}
		set {
			// foo bar
		}
	}
}

var q = Q()
q["x"] = "y"

