//
//  ContentView.swift
//  oio
//
//  Created by maryam almijlad on 11/12/2022.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    @State var learners :[Learner] = []
    var body: some View {
        NavigationView{
            List{
                ForEach(learners) { learner  in
                    HStack(spacing: 2){
                        Image("avatar\(Int.random(in: 1..<7))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .padding(.vertical)
                            .padding(.horizontal, 2)
                        
                        VStack(alignment: .leading, spacing:6){
                            Text("\(learner.name)")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("\(learner.age)")

                        }
                        .padding(6)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Learners")
            .onAppear{
                fetechlearners()
            }
        }
    }
    func fetechlearners(){
        
        print(CKContainer.default().containerIdentifier,"🧍🏾‍♀️")
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "learners", predicate:predicate )
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard error == nil else {
                print("Error: \(error)")
                return
            }
            
            guard let records = records else {return}
           learners = records.map {learner in
                let learner = Learner(record: learner)
               return learner
                
            }
           // print(records,"🧍🏾‍♀️")
        }

       // let operation = CKQueryOperation(query: query)
//        operation.recordMatchedBlock = { recordID, result in
//            switch result{
//        case.success(let record ):
//                print("🧍🏾‍♀️")
//            print(record["name"])
//            let learner = Learner(record: record)
//            learners.append(learner)
//
//
//        case.failure(let error):
//            print("error,\(error.localizedDescription) ")
//
//
//        }
           // CKContainer.default().publicCloudDatabase.add(operation)
           // CKContainer.default().publicCloudDatabase.add(operation)
            
        //}
        
    }
    func addlearners(){
        let record = CKRecord(recordType: "learners")
        record["name"] =  "look"
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard error == nil else{
                print("error,\(error!.localizedDescription) ")
                return
    }
        }
    
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let names: [String] = ["Nada Al Qahtani",
                       "Dalal Al Harbi",
                       "Shaden Al Otaibi",
                       "Sara Al Shehri",
                       "Reema Ahmed",
                       "Areej Al Rashid",
                       "Sara Mohammed"]

let majors: [String] = ["Computer Science",
                        "Physics",
                        "Computer Science",
                        "Chemistry",
                        "Biology",
                        "Computer Science",
                        "Artificial Intelligence"
]
struct Learner: Identifiable{
            let record: CKRecord
            let name: String
           let age: Int
            let major: String
             let lastname: String
            let id: CKRecord.ID
    
                  
            init(record:CKRecord){
               
                self.record = record
                self.id = record.recordID
                self.name = record["name"] as? String ?? ""
                self.lastname = record["lastname"] as? String ?? ""
                self.major = record["major"] as? String ?? ""
                self.age = record["age"] as? Int ?? 22
               
                
            }
        }
