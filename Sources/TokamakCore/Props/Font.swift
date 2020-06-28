// Copyright 2018-2020 Tokamak contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

public struct Font: Hashable {
  public let _name: String
  public let _size: CGFloat
  public let _design: Design
  public let _weight: Weight
  public let _smallCaps: Bool
  public let _italic: Bool
  public let _bold: Bool
  public let _monospaceDigit: Bool
  public let _leading: Leading

  public func italic() -> Self {
    .init(_name: _name, _size: _size, _design: _design, _weight: _weight, _smallCaps: _smallCaps, _italic: true, _bold: _bold, _monospaceDigit: _monospaceDigit, _leading: _leading)
  }

  public func smallCaps() -> Self {
    .init(_name: _name, _size: _size, _design: _design, _weight: _weight, _smallCaps: true, _italic: _italic, _bold: _bold, _monospaceDigit: _monospaceDigit, _leading: _leading)
  }

  public func lowercaseSmallCaps() -> Self {
    smallCaps()
  }

  public func uppercaseSmallCaps() -> Self {
    smallCaps()
  }

  public func monospacedDigit() -> Self {
    .init(_name: _name, _size: _size, _design: _design, _weight: _weight, _smallCaps: _smallCaps, _italic: _italic, _bold: _bold, _monospaceDigit: true, _leading: _leading)
  }

  public func weight(_ weight: Weight) -> Self {
    .init(_name: _name, _size: _size, _design: _design, _weight: weight, _smallCaps: _smallCaps, _italic: _italic, _bold: _bold, _monospaceDigit: _monospaceDigit, _leading: _leading)
  }

  public func bold() -> Self {
    .init(_name: _name, _size: _size, _design: _design, _weight: _weight, _smallCaps: _smallCaps, _italic: _italic, _bold: true, _monospaceDigit: _monospaceDigit, _leading: _leading)
  }

  public func leading(_ leading: Leading) -> Self {
    .init(_name: _name, _size: _size, _design: _design, _weight: _weight, _smallCaps: _smallCaps, _italic: _italic, _bold: true, _monospaceDigit: _monospaceDigit, _leading: leading)
  }
}

extension Font {
  public struct Weight: Hashable {
    public let value: Int

    public static let ultraLight: Self = .init(value: 100)
    public static let thin: Self = .init(value: 200)
    public static let light: Self = .init(value: 300)
    public static let regular: Self = .init(value: 400)
    public static let medium: Self = .init(value: 500)
    public static let semibold: Self = .init(value: 600)
    public static let bold: Self = .init(value: 700)
    public static let heavy: Self = .init(value: 800)
    public static let black: Self = .init(value: 900)
  }
}

extension Font {
  public enum Leading {
    case standard
    case tight
    case loose
  }
}

public enum _FontNames: String, CaseIterable {
  case system
}

extension Font {
  public static func system(size: CGFloat, weight: Weight = .regular, design: Design = .default) -> Self {
    .init(_name: _FontNames.system.rawValue, _size: size, _design: design, _weight: weight, _smallCaps: false, _italic: false, _bold: false, _monospaceDigit: false, _leading: .standard)
  }

  public enum Design: Hashable {
    case `default`
    case serif
    case rounded
    case monospaced
  }
}

struct FontKey: EnvironmentKey {
  static let defaultValue: Font? = nil
}

public extension EnvironmentValues {
  var font: Font? {
    get {
      self[FontKey.self]
    }
    set {
      self[FontKey.self] = newValue
    }
  }
}

public extension View {
  func font(_ font: Font?) -> some View {
    environment(\.font, font)
  }
}
