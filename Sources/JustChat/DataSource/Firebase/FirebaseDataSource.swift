import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

public class FirebaseDataSource {
    internal init(chatReference: String, ref: DatabaseReference? = Database.database().reference()) {
        self.chatReference = chatReference
        self.ref = ref
    }

    public init(chatReference: String) {
        self.chatReference = chatReference
    }

    var chatReference: String
    var ref: DatabaseReference!
    var user: UserProtocol!
}

extension FirebaseDataSource: DataSourceProtocol {
    
    public func initialization()  {
        Task {
            do {
                // pablocea
                // pablo
                // pablo0
                let authDataResult = try await Auth.auth().signIn(withEmail: "pablo0@rudo.es", password: "12345678A")
                print(authDataResult)
                ref = Database.database().reference()
                user = try await getUserInfo()
            } catch {
                print(error)
            }
        }
    }

    func getUserInfo() async throws -> FirebaseUser {
        let userID = try getUserID()
        let snapShot = try await ref.child("user").queryOrderedByKey().queryEqual(toValue: userID).getData()
        guard let userInfoDict = snapShot.value as? NSDictionary else { throw DataSourceError.noData }
        return try FirebaseParser.parseUserInfo(from: userInfoDict)
    }

    public func getUserID() throws -> String {
        if user != nil {
            return user.id
        }
        
        guard let userID = Auth.auth().currentUser?.uid else { throw DataSourceError.userNotFound }
        return userID
    }

    public func getChats() async throws -> [ChatProtocol] {
        var snapShots = [DataSnapshot]()
        for chatID in user.chatsIDs {
            async let snapShot = ref.child("chats/").queryOrderedByKey().queryEqual(toValue: chatID).getData()
            try await snapShots.append(snapShot)
        }

        var chats = [ChatProtocol]()
        for snapShot in snapShots {
            guard let chatsDict = snapShot.value as? NSDictionary else { throw DataSourceError.noData }
            let chat = try FirebaseParser.parseChat(from: chatsDict)
            chats.append(chat)
        }
        return chats
    }

    public func getChat(with id: String, completionCurrentChat: ((Result<ChatProtocol, DataSourceError>) -> Void)? = nil) {
        ref.child("chats/").queryOrderedByKey().queryEqual(toValue: id).observe(.value) { snapshot in
            do {
                guard let chatDict = snapshot.value as? NSDictionary else { throw DataSourceError.noData }
                let chat = try FirebaseParser.parseChat(from: chatDict)
                completionCurrentChat?(.success(chat))
            } catch {
                if let error = error as? DataSourceError {
                    completionCurrentChat?(.failure(error))
                } else { completionCurrentChat?(.failure(.unknownError)) }
            }
        }
    }

    public func send(this message: ChatMessageProtocol, for chatID: String) async throws {
        guard let key = ref.child("chats/\(chatID)/messages").childByAutoId().key else { throw DataSourceError.noData }
        let message: [String: Any] = ["text": message.message,
                                      "userID": message.userID,
                                      "timestamp": message.timestamp]
        let childUpdates = ["chats/\(chatID)/messages/\(key)": message]
        try await ref.updateChildValues(childUpdates)
    }

    public func didExitChat(id: String) {
        ref.child("chats/").queryOrderedByKey().queryEqual(toValue: id).removeAllObservers()
    }

    public func getUser() -> UserProtocol {
        return user
    }
}
