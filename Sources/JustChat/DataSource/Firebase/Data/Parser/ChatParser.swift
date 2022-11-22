//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import Foundation

class ChatParser {
    static func parseChats(from chatsList: NSDictionary) throws -> [ChatProtocol] {
        var chats = [ChatProtocol]()
        try chatsList.allKeys.forEach { chatKey in
            guard let chatKeyString = chatKey as? String,
                  let chatDict = chatsList.value(forKey: chatKeyString) as? NSDictionary else { throw FirebaseDataSource.FirebaseError.parseError }
            let chat = try parseChat(from: chatDict, with: chatKeyString)
            chats.append(chat)
        }

        return chats
    }

    static private func parseMessages(from chatDict: NSDictionary) throws -> [ChatMessageProtocol] {
        var messages = [ChatMessage]()
        if let messagesDict = chatDict.value(forKey: "messages") as? NSDictionary {
            try messagesDict.allKeys.forEach { messageKey in
                guard let messageKeyString = messageKey as? String,
                      let messageObject = messagesDict.value(forKey: messageKeyString) as? NSDictionary,
                let messageText = messageObject.value(forKey: "text") as? String,
                let messageUserId = messageObject.value(forKey: "userId") as? String,
                let messageTimestamp = messageObject.value(forKey: "timestamp") as? Int else { throw FirebaseDataSource.FirebaseError.parseError }

                let message = ChatMessage(id: messageKeyString,
                                          text: messageText,
                                          userId: messageUserId,
                                          timestamp: messageTimestamp)
                messages.append(message)
            }
        }
        messages.sort(by: { $0.timestamp < $1.timestamp })
        return messages
    }

    static func parseChat(from chatDict: NSDictionary, with chatKeyString: String) throws -> ChatProtocol {
        guard let chatName = chatDict.value(forKey: "name") as? String,
              let otherUserId = chatDict.value(forKey: "otherUserId") as? String,
              let otherUserImage = chatDict.value(forKey: "otherUserImage") as? String else { throw FirebaseDataSource.FirebaseError.parseError }

        let messages = try parseMessages(from: chatDict)

        let chat = Chat(id: chatKeyString,
                        name: chatName,
                        otherUserId: otherUserId,
                        otherUserImage: otherUserImage,
                        messages: messages)
        return chat
    }
}
