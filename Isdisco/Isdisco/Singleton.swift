//
//  Singleton.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 28/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//
//  Get data from class by calling "Singleton.shared.*" anywhere in the project
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
        songRequests.append(SongRequest(user: users[1], track: tracks[1], timeStamp: 2.4, reqId: 1))
        songRequests.append(SongRequest(user: users[2], track: tracks[2], timeStamp: 2.5, reqId: 2))
        songRequests.append(SongRequest(user: users[3], track: tracks[3], timeStamp: 2.6, reqId: 3))
        songRequests.append(SongRequest(user: users[4], track: tracks[4], timeStamp: 2.7, reqId: 4))
        songRequests.append(SongRequest(user: users[5], track: tracks[5], timeStamp: 2.8, reqId: 5))
        songRequests.append(SongRequest(user: users[6], track: tracks[6], timeStamp: 2.9, reqId: 6))
        songRequests.append(SongRequest(user: users[7], track: tracks[7], timeStamp: 3.4, reqId: 7))
        songRequests.append(SongRequest(user: users[8], track: tracks[8], timeStamp: 5.4, reqId: 8))
        songRequests.append(SongRequest(user: users[9], track: tracks[0], timeStamp: 1.4, reqId: 9))
        songRequests.append(SongRequest(user: users[10], track: tracks[1], timeStamp: 5.4, reqId: 10))
        songRequests.append(SongRequest(user: users[11], track: tracks[2], timeStamp: 2.2, reqId: 11))
        songRequests.append(SongRequest(user: users[12], track: tracks[3], timeStamp: 2.8, reqId: 12))
        songRequests.append(SongRequest(user: users[13], track: tracks[4], timeStamp: 2.4, reqId: 13))
        songRequests.append(SongRequest(user: users[14], track: tracks[5], timeStamp: 6.4, reqId: 14))
        songRequests.append(SongRequest(user: users[0], track: tracks[6], timeStamp: 2.2, reqId: 15))
        songRequests.append(SongRequest(user: users[1], track: tracks[7], timeStamp: 7.4, reqId: 16))

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
