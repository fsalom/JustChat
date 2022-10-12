import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

public class JustChatManager {
    var shared = JustChatManager()
    
    public init() {
        FirebaseApp.configure()
    }
}
