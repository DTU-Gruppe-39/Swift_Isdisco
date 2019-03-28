//
//  Singleton.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 28/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation

class Singleton {
    
    // MARK: - Properties
    static let shared = Singleton()
    
    // Initialization
    var tracks = [Track]()
    var users = [User]()
    var songRequests = [SongRequest]()
    
    private init() {}
    
    func setUpData() {
        tracks.append(Track(title: "Despacito" , artist: "Luis Fonsi", genre: "Pop", albumArt: "URL"))
        tracks.append(Track(title: "American Idiot", artist: "Green Day", genre: "Rock", albumArt: "URL"))
        tracks.append(Track(title: "7 Rings", artist: "Ariana Grande", genre: "Pop", albumArt: "URL"))
        tracks.append(Track(title: "Sucker", artist: "Jonas Brothers", genre: "Pop", albumArt: "URL"))
        tracks.append(Track(title: "Sunflower", artist: "Post Malone", genre: "Pop", albumArt: "URL"))
        tracks.append(Track(title: "Shallow", artist: "Lady Gaga", genre: "Pop", albumArt: "URL"))
        tracks.append(Track(title: "Sweet but Psycho", artist: "Ava Max", genre: "Pop", albumArt: "URL"))
        tracks.append(Track(title: "Gangnam Style", artist: "Psy", genre: "K-Pop", albumArt: "URL"))
        tracks.append(Track(title: "Nede Mette", artist: "Blak", genre: "Pop", albumArt: "URL"))
        
        users.append(User(name: "Jacob", userId: 0))
        users.append(User(name: "Mathias", userId: 1))
        users.append(User(name: "Jonas", userId: 2))
        users.append(User(name: "Mikkel", userId: 3))
        users.append(User(name: "Søren", userId: 4))
        users.append(User(name: "Thomas", userId: 5))
        users.append(User(name: "Line", userId: 6))
        users.append(User(name: "Sofie", userId: 7))
        users.append(User(name: "Troels", userId: 8))
        users.append(User(name: "Sara", userId: 9))
        users.append(User(name: "Emilie", userId: 10))
        users.append(User(name: "Alexander", userId: 11))
        users.append(User(name: "Louise", userId: 12))
        users.append(User(name: "Emma", userId: 13))
        users.append(User(name: "Stefan", userId: 14))
        
        songRequests.append(SongRequest(user: users[0], track: tracks[0], timeStamp: 1.3, reqId: 0))
    }
    
    

    // MARK: -
    
    
    
    class Track {
        let albumArt: String
        let title: String
        let artist: String
        let genre: String
        
        init(title: String, artist: String, genre: String, albumArt: String) {
            self.albumArt = albumArt
            self.title = title
            self.artist = artist
            self.genre = genre
        }
    }
    
    class User {
        let name: String
        let userId: Int
        
        init(name: String, userId: Int) {
            self.name = name
            self.userId = userId
        }
    }
    
    class SongRequest {
        let user: User
        let track: Track
        let timeStamp: Double
        let reqId: Int
        var votes: Int
    
        init(user: User, track: Track, timeStamp: Double, reqId: Int) {
            self.user = user
            self.track = track
            self.timeStamp = timeStamp
            self.reqId = reqId
            self.votes = 1
        }
    }
}
