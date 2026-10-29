# Security

Report a vulnerability privately to the repository owner. Do not open a public issue for an unfixed security bug.

## Expectations in this codebase

- Secrets live in environment variables, never in git.
- AI provider keys stay on the server.
- The mobile app does not collect card numbers or mobile-money PINs.
- Payment webhooks are verified before an order is marked paid.
- Location, Bluetooth, and analytics require an explicit consent screen.
- The app does not keep the microphone open.

`docs/SECURITY_PRIVACY.md` will hold the product privacy notes as those screens are built.
