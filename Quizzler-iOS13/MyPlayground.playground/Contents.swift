struct Person {
    var name = "Name"
    var surname = "Surname"
    var age = 0
    var children = ["AA", "BBB", "CCC" ]
    var items = ["car" : "Toyota", "house" : "Serikova", "job" : "Business center"]
    
    init(_ name: String, _ surname: String) {
        self.name = name
        self.surname = surname
        
    }
    
    func updateName(str: String) {
        print("Update not possible \(str)")
    }
}

let person = Person("asdfasdf", "Surname" )
person.updateName(str: "New name")
print(person)
