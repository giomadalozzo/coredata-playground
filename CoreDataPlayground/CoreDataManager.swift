import CoreData
import UIKit

class CoreDataManager {
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataPlayground")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // MARK: - Create Data
    
    func createData() -> String{
        
        let fallen = Player(context: persistentContainer.viewContext)
        fallen.nick = "FalleN"
        fallen.nationality = "Brazilian"
        fallen.yearBorn = 1991
        
        let fer = Player(context: persistentContainer.viewContext)
        fer.nick = "fer"
        fer.nationality = "Brazilian"
        fer.yearBorn = 1991
        
        let s1mple = Player(context: persistentContainer.viewContext)
        s1mple.nick = "s1mple"
        s1mple.nationality = "Ukrainian"
        s1mple.yearBorn = 1997
        
        let b1t = Player(context: persistentContainer.viewContext)
        b1t.nick = "b1t"
        b1t.nationality = "Ukrainian"
        b1t.yearBorn = 2003
        
        let gla1ve = Player(context: persistentContainer.viewContext)
        gla1ve.nick = "gla1ve"
        gla1ve.nationality = "Danish"
        gla1ve.yearBorn = 1995
        
        let xyp9x  = Player(context: persistentContainer.viewContext)
        xyp9x.nick = "Xyp9x"
        xyp9x.nationality = "Danish"
        xyp9x.yearBorn = 1995
        

        
        let navi = Team(context: persistentContainer.viewContext)
        navi.nationality = "Ukraine"
        navi.hltvRank = 1
        navi.name = "Natus Vincere"
        s1mple.acutalTeam = navi
        b1t.acutalTeam = navi
        
        let imperial = Team(context: persistentContainer.viewContext)
        imperial.nationality = "Brazil"
        imperial.hltvRank = 74
        imperial.name = "Imperial"
        fallen.acutalTeam = imperial
        fer.acutalTeam = imperial
        
        let astralis = Team(context: persistentContainer.viewContext)
        astralis.nationality = "Denmark"
        astralis.hltvRank = 10
        astralis.name = "Astralis"
        xyp9x.acutalTeam = astralis
        gla1ve.acutalTeam = astralis
        
        
        
        let atlanta2017 = Major(context: persistentContainer.viewContext)
        atlanta2017.name = "ELEAGUE Major: Atlanta"
        atlanta2017.location = "Atlanta"
        atlanta2017.year = 2017
        atlanta2017.playerWon = NSSet(array: [gla1ve,xyp9x])
        
        let london2018 = Major(context: persistentContainer.viewContext)
        london2018.name = "FACEIT Major: London"
        london2018.location = "London"
        london2018.year = 2018
        london2018.playerWon = NSSet(array: [gla1ve,xyp9x])
        
        let katowice2019 = Major(context: persistentContainer.viewContext)
        katowice2019.name = "Intel Extreme Masters XIII - Katowice Major"
        katowice2019.location = "Katowice"
        katowice2019.year = 2019
        katowice2019.playerWon = NSSet(array: [gla1ve,xyp9x])
        
        let berlin2019 = Major(context: persistentContainer.viewContext)
        berlin2019.name = "StarLadder Berlin Major"
        berlin2019.location = "Berlin"
        berlin2019.year = 2019
        berlin2019.playerWon = NSSet(array: [gla1ve,xyp9x])
        
        let stock2021 = Major(context: persistentContainer.viewContext)
        stock2021.name = "PGL Major Stockholm"
        stock2021.location = "Stockholm"
        stock2021.year = 2021
        stock2021.playerWon = NSSet(array: [s1mple,b1t])
        
        let columbus2016 = Major(context: persistentContainer.viewContext)
        columbus2016.name = "MLG Major Championship: Columbus"
        columbus2016.location = "Columbus"
        columbus2016.year = 2016
        columbus2016.playerWon = NSSet(array: [fallen,fer])
        
        let cologne2016 = Major(context: persistentContainer.viewContext)
        cologne2016.name = "ESL One: Cologne"
        cologne2016.location = "Cologne"
        cologne2016.year = 2016
        cologne2016.playerWon = NSSet(array: [fallen,fer])
        
        
        
        do {
            try persistentContainer.viewContext.save()
            return "Data created"
        } catch {
            return "\(error)"
        }
        
    }
    
    func deleteData() -> String{
        do {
            let allTeams = try persistentContainer.viewContext.fetch(Team.fetchRequest())
            allTeams.forEach {
                persistentContainer.viewContext.delete($0)
            }
            
            let allPlayers = try persistentContainer.viewContext.fetch(Player.fetchRequest())
            allPlayers.forEach {
                persistentContainer.viewContext.delete($0)
            }
            
            let allMajors = try persistentContainer.viewContext.fetch(Major.fetchRequest())
            allMajors.forEach {
                persistentContainer.viewContext.delete($0)
            }
            
            try persistentContainer.viewContext.save()
            
            return "Data deleted"
        } catch {
            return "\(error)"
        }
        
    }
    
    func allPlayers() -> String{
        do {
            let players = try persistentContainer.viewContext.fetch(Player.fetchRequest())
            let formatted = players.map { "\t\($0)" }.joined(separator: "\n")
            return "Query - all players:\n\(formatted)\n"
        } catch {
            return "Error on query: \(error)\n"
        }
    }
    
    func allTeams() -> String {
        do {
            let teams = try persistentContainer.viewContext.fetch(Team.fetchRequest())
            let formatted = teams.map { "\t\($0)" }.joined(separator: "\n")
            return "Query - all teams:\n\(formatted)\n"
        } catch {
            return "Error on query: \(error)\n"
        }
    }
}

extension Player {
    override public var description: String{
        let titleList = majorWon?.allObjects as? [Major]
        var titles: [String] = []
        for major in titleList! {
            titles.append(major.name!)
        }
        
        return "\(nick ?? "") (\(nationality ?? ""), \(yearBorn)) - Playing for \(acutalTeam?.name ?? ""). Won: \(titles.joined(separator: ", "))"
    }
}

extension Team {
    override public var description: String{
        let playerList = players?.allObjects as? [Player]
        var line: [String] = []
        for player in playerList! {
            line.append(player.nick!)
        }
        
        return "\(name ?? "") (\(nationality ?? ""), HLTV rank \(hltvRank)). Players registered:  \(line.joined(separator: ", "))"
    }
}
