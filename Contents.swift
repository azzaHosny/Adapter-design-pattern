
import Foundation
import EventKit

// it transforms the interface of an object to adapt it to a different object.

//So adapter can transform one thing into another, sometimes it's called wrapper, because it wraps the object and provides a new interface around it. It's like a software dongle for specific interfaces or legacy classes. (Dongle haters: it's time to leave the past behind!)


enum DateFormat: String {
    case utcFormate = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    case clientFormat = "yyyy-MM-dd HH:mm:ss"
    case clintFormat12hr = "yyyy-MM-dd hh:mm a"
    case hoursFormate = "hh:mm a"
    case dayMonth = "MMM dd"
    case dayMonthShort = "MM-dd"
    case datePart = "dd - MM - yyyy"
    case timePart = " HH:mm:ss "
    case fullDateTime = "MM/dd/yyyy HH:mm:ss"
}

protocol Event {
    var title: String {get}
    var startDate: String {get}
    var endDate: String {get}
}

class EventAdapter {
    
    private var event: EKEvent
    private var dateFormate: DateFormat
    
    init(event: EKEvent, dateFormate: DateFormat) {
        self.event = event
        
        self.dateFormate = dateFormate
    }
    private lazy var dataFormater: DateFormatter = {
        let dataFormater = DateFormatter()
        dataFormater.dateFormat = dateFormate.rawValue
        return dataFormater
    }()
    
}
extension EventAdapter: Event {
    var title: String {
        return self.event.title
    }
    
    var startDate: String {
        return self.dataFormater.string(from: event.startDate)
    }
    
    var endDate: String {
        return self.dataFormater.string(from: event.endDate)
    }
    
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = DateFormat.fullDateTime.rawValue

let calnderEvent = EKEvent(eventStore: EKEventStore())

calnderEvent.startDate = dateFormatter.date(from: "07/30/2020 10:00:00")
calnderEvent.endDate = dateFormatter.date(from: "07/11/2021 08:00:00")
calnderEvent.title = "Azah"

let adapter = EventAdapter(event: calnderEvent, dateFormate: .timePart)
print(adapter.startDate, adapter.endDate, adapter.title)
