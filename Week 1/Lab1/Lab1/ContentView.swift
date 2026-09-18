import SwiftUI

struct ContentView: View {
    let studentName = "Duong Ngoc Anh Thu"
    let studentID = "SESEIU24026"
    let age = 20
    let gpa = 3.0
    let isStudent = true

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.35),
                    Color.cyan.opacity(0.18),
                    Color.green.opacity(0.35)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                // Graduatio    n icon
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.75))
                        .frame(width: 125, height: 125)

                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(
                            .blue,
                            .yellow
                        )
                }

                Text("Student Profile")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.blue)

                VStack(spacing: 10) {
                    informationRow(
                        icon: "person.fill",
                        title: "Name",
                        value: studentName,
                        color: .blue
                    )

                    informationRow(
                        icon: "person.text.rectangle.fill",
                        title: "Student ID",
                        value: studentID,
                        color: .blue
                    )

                    informationRow(
                        icon: "calendar",
                        title: "Age",
                        value: "\(age)",
                        color: .blue
                    )

                    informationRow(
                        icon: "chart.bar.fill",
                        title: "GPA",
                        value: gpa.formatted(
                            .number.precision(.fractionLength(1))
                        ),
                        color: .blue
                    )

                    informationRow(
                        icon: isStudent
                            ? "checkmark.circle.fill"
                            : "xmark.circle.fill",
                        title: "Student",
                        value: isStudent ? "true" : "false",
                        color: isStudent ? .green : .red
                    )
                }
                .padding(.horizontal, 20)

                Spacer()

                VStack(spacing: 5) {
                    Text("A brighter tomorrow")
                        .font(.system(size: 15, design: .rounded))
                        .italic()

                    Text("begins with what you learn today")
                        .font(.system(size: 14, design: .rounded))
                        .italic()

                    Text("♥")
                        .foregroundStyle(.red)
                        .font(.title3)
                }
                .foregroundStyle(.brown)
                .padding(.bottom, 20)
            }
            .padding(.top, 35)
            .padding(.horizontal, 20)
        }
    }

    func informationRow(
        icon: String,
        title: String,
        value: String,
        color: Color
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(color)
                .frame(width: 25)

            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.primary)

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(
                    title == "Student" ? color : .primary
                )
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding(.horizontal, 14)
        .frame(height: 43)
        .background(.white.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
}
