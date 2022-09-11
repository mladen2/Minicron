@main
public struct Minicron {
    public static func main() {
        print(String.newLine)
        let mainHarness = MainHarness(arguments: CommandLine.arguments, runner: Runner.shared)
        do {
            try mainHarness.run()
        } catch {
            if let error = error as? MyError {
                pr(error, message: "Error")
            } else {
                pr("\(error), Error")
            }
        }
        print(String.newLine)
    }
}
