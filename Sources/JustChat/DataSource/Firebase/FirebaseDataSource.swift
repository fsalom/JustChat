import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

public class FirebaseDataSource {
    internal init(chatReference: String, ref: DatabaseReference? = Database.database().reference(), completionChats: (([ChatProtocol]) -> Void)? = nil, completionCurrentChat: (([ChatMessageProtocol]) -> Void)? = nil, completionMessageReceive: (([ChatMessageProtocol]) -> Void)? = nil) {
        self.chatReference = chatReference
        self.ref = ref
        self.completionChats = completionChats
        self.completionCurrentChat = completionCurrentChat
        self.completionMessageReceive = completionMessageReceive
    }

    var chatReference: String
    var ref: DatabaseReference!
    var completionChats: (([ChatProtocol]) -> Void)?
    var completionCurrentChat: (([ChatMessageProtocol]) -> Void)?
    var completionMessageReceive: (([ChatMessageProtocol]) -> Void)?

    public init(chatReference: String) {
        self.chatReference = chatReference
    }
}

extension FirebaseDataSource: DataSourceProtocol {
    enum FirebaseError: Error {
        case userNotFound
        case noData
        case parseError

    }
    public func initialization() {
        Auth.auth().signIn(withEmail: "pablocea@rudo.es", password: "12345678A") { authResult, error in
            if let error = error {
                print(error)
            }
            print(authResult)

        }
        ref = Database.database().reference()
    }

    public func getUserID() throws -> String {
        guard let userID = Auth.auth().currentUser?.uid else { throw FirebaseError.userNotFound }
        return userID
    }

    public func getChats(with parameters: [String : Any]) async throws -> [ChatProtocol] {
        guard let userID = Auth.auth().currentUser?.uid else { throw FirebaseError.userNotFound }
        let snapShot = try await ref.child("users/\(userID)/chats").getData()
        guard let chatsDict = snapShot.value as? NSDictionary else { throw FirebaseError.noData}

        return try ChatParser.parseChats(from: chatsDict)
    }

    public func getChat(with id: String) async throws -> ChatProtocol {
        return Chat(id: "", name: "", lastMessage: "", otherUserId: "", otherUserImage: "", messages: [])
    }

    public func send(this message: ChatMessageProtocol) async throws {

    }

    public func receive(this message: ChatMessageProtocol) async throws {

    }
}
