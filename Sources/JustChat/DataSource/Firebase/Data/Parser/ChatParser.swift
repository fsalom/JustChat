//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import Foundation

class ChatParser {
    static func parseChats(from chatsList: NSDictionary) throws -> [Chat] {
        var chats = [Chat]()
        try chatsList.allKeys.forEach { chatKey in
            guard let chatKeyString = chatKey as? String,
                  let chatDict = chatsList.value(forKey: chatKeyString) as? NSDictionary,
                  let chatName = chatDict.value(forKey: "name") as? String,
                  let otherUserId = chatDict.value(forKey: "otherUserId") as? String,
                  let otherUserImage = chatDict.value(forKey: "otherUserImage") as? String else { throw FirebaseDataSource.FirebaseError.parseError }

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

            let chat = Chat(id: chatKeyString,
                            name: chatName,
                            lastMessage: chatDict.value(forKey: "lastMessage") as? String ?? "",
                            otherUserId: otherUserId,
                            otherUserImage: otherUserImage,
                            messages: messages)
            chats.append(chat)
        }

        return chats
    }
}
