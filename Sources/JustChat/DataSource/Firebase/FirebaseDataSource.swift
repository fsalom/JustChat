import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

public class FirebaseDataSource {
    internal init(chatReference: String, ref: DatabaseReference? = Database.database().reference()) {
        self.chatReference = chatReference
        self.ref = ref
    }

    var chatReference: String
    var ref: DatabaseReference!

    public init(chatReference: String) {
        self.chatReference = chatReference
    }
}

extension FirebaseDataSource: DataSourceProtocol {
    enum FirebaseError: Error {
        case userNotFound
        case noData
        case parseError
        case unknownError

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

    public func getChat(with id: String, completionCurrentChat: ((ChatProtocol) -> Void)? = nil) throws {
        guard let userID = Auth.auth().currentUser?.uid else { throw FirebaseError.userNotFound }
        ref.child("/users/\(userID)/chats/\(id)").observe(.value) { snapshot in
            do {
                guard let chatDict = snapshot.value as? NSDictionary else { throw FirebaseError.noData }
                let chat = try ChatParser.parseChat(from: chatDict, with: id)
                completionCurrentChat?(chat)
            } catch {
                // TODO
                print(error)
            }
        }
    }

    public func send(this message: ChatMessageProtocol, for chatID: String) async throws {
        guard let userID = Auth.auth().currentUser?.uid else { throw FirebaseError.userNotFound }
        guard let key = ref.child("users\(userID)/chats/\(chatID)/messages").childByAutoId().key else { throw FirebaseError.noData }
        let message: [String: Any] = ["text": message.message,
                                      "userId": message.userID,
                                      "timestamp": message.timestamp]
        let childUpdates = ["/users/\(userID)/chats/\(chatID)/messages/\(key)": message]
        try await ref.updateChildValues(childUpdates)

    }

    public func receive(this message: ChatMessageProtocol) async throws {

    }
}
