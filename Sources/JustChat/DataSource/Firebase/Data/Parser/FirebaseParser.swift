//
//  FirebaseParser.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import Foundation

class FirebaseParser {
    static func parseUserInfo(from userInfo: NSDictionary) throws -> FirebaseUser {
        guard let id = (userInfo.allKeys as? [String])?.first,
              let userInfoDict = userInfo.value(forKey: id) as? NSDictionary,
              let chatsIDs = (userInfoDict.value(forKey: "chats") as? NSDictionary)?.allKeys as? [String] else { throw DataSourceError.parseError }
        let profilePhoto = userInfo["profilePhoto"] as? String
        let name = userInfo["name"] as? String

        return FirebaseUser(id: id,
                            chatsIDs: chatsIDs,
                            profilePhotoURL: profilePhoto ?? "",
                            name: name ?? "")
    }

    static func parseChat(from chatDict: NSDictionary) throws -> ChatProtocol {
        guard let id = (chatDict.allKeys as? [String])?.first,
              let chatValue = chatDict.value(forKey: id) as? NSDictionary,
              let chatName = chatValue.value(forKey: "name") as? String,
              let photo = chatValue.value(forKey: "photo") as? String,
              let typeString = chatValue.value(forKey: "type") as? String,
              let type = ChatType(rawValue: typeString),
              let usersDict = chatValue.value(forKey: "users") as? NSDictionary,
              let users = usersDict.allKeys as? [String] else { throw DataSourceError.parseError }

        let messages = try parseMessages(from: chatValue)
        let messagesResult = getMessagesPerDay(from: messages)


        let chat = Chat(id: id,
                        name: chatName,
                        photo: photo,
                        users: users,
                        messages: messagesResult,
                        type: type)
        return chat
    }

    static func getMessagesPerDay(from messages: [ChatMessageProtocol], result: [[ChatMessageProtocol]] = []) -> [[ChatMessageProtocol]] {
        if messages.isEmpty { return result }
        var messagesInDay = [ChatMessageProtocol]()
        var auxMessages = messages
        var auxResult = result
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date(timeIntervalSince1970: TimeInterval(auxMessages.first!.timestamp)))
        auxMessages.removeAll { message in
            let dateComponentsOther = Calendar.current.dateComponents([.day, .month, .year], from: Date(timeIntervalSince1970: TimeInterval(message.timestamp)))
            if dateComponents == dateComponentsOther {
                messagesInDay.append(message)
                return true
            } else {
                return false
            }
        }

        auxResult.append(messagesInDay)

        return getMessagesPerDay(from: auxMessages, result: auxResult)
    }

    static private func parseMessages(from chatDict: NSDictionary) throws -> [ChatMessageProtocol] {
        var messages = [ChatMessage]()
        if let messagesDict = chatDict.value(forKey: "messages") as? NSDictionary {
            try messagesDict.allKeys.forEach { messageKey in
                guard let messageKeyString = messageKey as? String,
                      let messageObject = messagesDict.value(forKey: messageKeyString) as? NSDictionary,
                      let messageText = messageObject.value(forKey: "text") as? String,
                      let messageUserId = messageObject.value(forKey: "userID") as? String,
                      let messageTimestamp = messageObject.value(forKey: "timestamp") as? Int else { throw DataSourceError.parseError }

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
}
