import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class FirebaseDataSource {
    var chatReference: String
    var ref: DatabaseReference! = Database.database().reference()
    var completionChats: (([ChatProtocol]) -> Void)?
    var completionCurrentChat: (([ChatMessageProtocol]) -> Void)?
    var completionMessageReceive: (([ChatMessageProtocol]) -> Void)?

    init(chatReference: String) {
        self.chatReference = chatReference
    }
}

extension FirebaseDataSource: DataSourceProtocol {
    func initialization() {
        FirebaseApp.configure()
    }

    func getChats(with parameters: [String : Any]) async throws -> [ChatProtocol] {
        let userID = Auth.auth().currentUser?.uid
        ref.child(chatReference).child(userID!).observeSingleEvent(of: .value, with: { snapshot in
          let value = snapshot.value as? NSDictionary
          let username = value?["username"] as? String ?? ""            
        }) { error in
          print(error.localizedDescription)
        }
        return []
    }

    func getChat(with id: String) async throws -> ChatProtocol {
        return Chat(id: "example", name: "test", group: "")
    }

    func send(this message: ChatMessageProtocol) async throws {

    }

    func receive(this message: ChatMessageProtocol) async throws {

    }
}
