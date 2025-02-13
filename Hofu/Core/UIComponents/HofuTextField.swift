import SwiftUI

struct HofuTextField: View {
    let title: String?
    let placeholder: String
    let helperText: String?
    let leadingIcon: Image?
    let trailingIcon: Image?
    let isError: Bool
    let obscureText: Bool
    let obscureCharacter: Character
    let isEnabled: Bool // Added isEnabled property
    let onLeadingIconTap: (() -> Void)?
    let onTrailingIconTap: (() -> Void)?
    let onChange: (String) -> Void
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isTextVisible: Bool = false
    
    init(
        title: String? = nil,
        placeholder: String,
        text: Binding<String>,
        helperText: String? = nil,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        isError: Bool = false,
        obscureText: Bool = false,
        obscureCharacter: Character = "•",
        isEnabled: Bool = true, // Added isEnabled parameter with default value
        onLeadingIconTap: (() -> Void)? = nil,
        onTrailingIconTap: (() -> Void)? = nil,
        onChange: @escaping (String) -> Void
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.helperText = helperText
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isError = isError
        self.obscureText = obscureText
        self.obscureCharacter = obscureCharacter
        self.isEnabled = isEnabled
        self.onLeadingIconTap = onLeadingIconTap
        self.onTrailingIconTap = onTrailingIconTap
        self.onChange = onChange
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Title
            if let title = title {
                Text(title)
                    .style(.textMd())
                    .foregroundColor(isEnabled ? .gray600 : .gray400).padding(.bottom, 4)
            }
            
            // TextField Container
            HStack(spacing: 8) {
                // Leading Icon
                if let leadingIcon = leadingIcon {
                    leadingIcon
                        .renderingMode(.template)
                        .foregroundColor(isEnabled ? .gray700 : .gray400)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            if isEnabled {
                                onLeadingIconTap?()
                            }
                        }
                }
                
                // TextField or SecureField with ZStack for proper text alignment
                ZStack(alignment: .leading) {
                    if obscureText && !isTextVisible {
                        SecureField("", text: $text, prompt: Text(placeholder)
                            .style(.textMd())
                            .foregroundColor(.gray400))
                            .focused($isFocused)
                            .onChange(of: text) { _, newValue in
                                if isEnabled {
                                    text = newValue
                                    onChange(newValue)
                                }
                            }
                            .foregroundStyle(isEnabled ? .gray600 : .gray400)
                            .disabled(!isEnabled)
                    } else {
                        TextField("", text: $text, prompt: Text(placeholder).style(.textMd()).foregroundColor(
                            .gray400
                        ))
                        .font(.interFont(.regular, 16))
                        .foregroundColor(isEnabled ? .gray600 : .gray400)
                        .focused($isFocused)
                        .onChange(of: text) { _, newValue in
                            if isEnabled {
                                text = newValue
                                onChange(newValue)
                            }
                        }
                
                        .disabled(!isEnabled)
                    }
                }
                
                // Right side icons container
                HStack(spacing: 8) {
                    // Clear Button
                    if !text.isEmpty && isEnabled {
                        Button(action: {
                            text = ""
                            onChange("")
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray400)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    // Show/Hide Password Button for obscureText
                    if obscureText && isEnabled {
                        Button(action: {
                            isTextVisible.toggle()
                        }) {
                            Image(systemName: isTextVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray600)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    // Trailing Icon
                    if let trailingIcon = trailingIcon {
                        trailingIcon
                            .renderingMode(.template)
                            .foregroundColor(isEnabled ? .gray600 : .gray400)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                if isEnabled {
                                    onTrailingIconTap?()
                                }
                            }
                    }
                }
            }
            .padding([.horizontal], 14)
            .padding([.vertical], 12)
            .background(isEnabled ? Color.white : Color.gray100)
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(
                        isEnabled ? (isFocused ? .brand600 :
                            isError ? .error600 :
                            .gray300) : .gray300,
                        lineWidth: 1
                    )
            )
            
            // Helper Text
            if let helperText = helperText {
                Text(helperText)
                    .font(.caption)
                    .foregroundColor(isEnabled ? (isError ? .red : .gray) : .gray400).padding(.top, 4)
            }
        }
    }
}

#Preview {
    @Previewable @State var testText = ""

    VStack(spacing: 20) {
        // Normal Text Field
        HofuTextField(
            title: "Username",
            placeholder: "Enter your username",
            text: $testText,
            helperText: nil,
            leadingIcon: Image(systemName: "person"),
            trailingIcon: Image(systemName: "info.circle"),
            onLeadingIconTap: { print("Leading icon tapped") },
            onTrailingIconTap: { print("Trailing icon tapped") },
            onChange: { text in
                testText = text
            }
        )
        
        // Disabled Text Field
        HofuTextField(
            title: "Disabled Field",
            placeholder: "This field is disabled",
            text: $testText,
            helperText: "You cannot edit this field",
            leadingIcon: Image(systemName: "person"),
            isEnabled: false,
            onChange: { _ in }
        )
        
        // Password Field
        HofuTextField(
            title: "Password",
            placeholder: "Enter your password",
            text: $testText,
            helperText: "Minimum 8 characters",
            leadingIcon: Image(systemName: "lock"),
            obscureText: true,
            obscureCharacter: "•",
            onChange: { _ in }
        )
    }
    .padding()
}
