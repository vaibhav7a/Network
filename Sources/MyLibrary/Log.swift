import Foundation

enum LogPrefix: String {
    case error = "[‼️]"
    case info = "[ℹ️]"
    case debug = "[💬]"
    case verbose = "[🔬]"
    case warning = "[⚠️]"
    case severe = "[🔥]"
}

enum LogLevel {
    case debug
    case release
}

class Log {

    static var logLevel: LogLevel = .debug
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    class func e(_ message: String,
                 filename: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcname: String = #function) {
        if logLevel == .debug {
            print("\(Date().toString()) \(LogPrefix.error.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcname) -> \(message)")
        }
    }
    class func i(_ message: String,
                 filename: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcname: String = #function) {
        if logLevel == .debug {
            print("\(Date().toString()) \(LogPrefix.info.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcname) -> \(message)")
        }
    }
    class func d(_ message: String,
                 filename: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcname: String = #function) {
        if logLevel == .debug {
            print("\(Date().toString()) \(LogPrefix.debug.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcname) -> \(message)")
        }
    }
    class func v(_ message: String,
                 filename: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcname: String = #function) {
        if logLevel == .debug {
            print("\(Date().toString()) \(LogPrefix.verbose.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcname) -> \(message)")
        }
    }
    class func w(_ message: String,
                 filename: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcname: String = #function) {
        if logLevel == .debug {
            print("\(Date().toString()) \(LogPrefix.warning.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcname) -> \(message)")
        }
    }
    class func s(_ message: String,
                 filename: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcname: String = #function) {
        if logLevel == .debug {
            print("\(Date().toString()) \(LogPrefix.severe.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcname) -> \(message)")
        }
    }
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
internal extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
