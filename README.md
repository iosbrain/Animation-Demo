# Animation Demo
Xcode/Swift project demonstrating basic block animation, Auto Layout, and view geometry.

## Xcode 8.2.1 project settings
This app will run on the Simulator as soon as you build it. To get this project running on a physical **device (iPhone, iPad)**, go to the following locations in Xcode and make the suggested changes:

1. Xcode -> [Project Name] -> TARGETS -> [Target Name] -> General -> Signing
- [ ] Tick the "Automatically manage signing" box
- [ ] Select a valid name from the "Team" dropdown
  
2. Xcode -> [Project Name] -> TARGETS -> [Target Name] -> General -> Identity
- [ ] Change the "com.yourdomain" portion of the value in the "Bundle Identifier" text field to your real reverse domain name (i.e., "com.yourRealDomainName.Project-Name").
