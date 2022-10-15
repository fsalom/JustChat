class Chat {
    var id: String
    var name: String
    var group: String

    init(id: String, name: String, group: String) {
        self.id = id
        self.name = name
        self.group = group
    }
}

extension Chat: ChatProtocol{
    var idChat: String {
        return self.id
    }

    var nameChat: String {
        return self.name
    }
}
