# Negarit AI — Software Requirements Specification

> Extracted from `Negarit_AI_SRS_v2.pdf` on 2026-10-29 for agent use.
> Pages: 13. Extraction: PyMuPDF `get_text("text")` (pdftotext was not installed).

<!-- page 1 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 1
Confidential - Negarit AI team
NEGARIT AI
Software Requirements Specification and Cursor Agent
Implementation Brief
A multilingual, beacon-triggered visitor companion and local commerce platform for museums,
parks and large visitor sites. First venue: Adwa Museum.
Version
2.0 (revised: language, wayfinding, ads and payments focus)
Date
October 28, 2026
Target launch
October 31, 2026 (MVP)
Stack
Flutter + Dart, NestJS + TypeScript, PostgreSQL + PostGIS + pgvector
Primary detection
BLE beacons (iBeacon / Eddystone); NFC and RFID secondary

<!-- page 2 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 2
Confidential - Negarit AI team
1. Product vision and the problem we solve
Visitors to large sites such as Adwa Museum face three recurring problems: a language barrier with human
guides, not knowing where things are (coffee, restaurants, parking, exhibits, restrooms), and no connection
between the visit and local businesses that sell related artifacts, clothing, food and services.
Negarit AI solves these together. When a visitor walks in, the app detects the venue by Bluetooth, greets them in
their own language, and from then on guides them zone by zone. At each beacon it explains the exhibit, shows
where nearby facilities are, and, where relevant, presents a clearly labeled local offer that can be paid for with
Telebirr or Chapa.
1.1 The three pillars (in priority order)
Pillar
What the visitor gets
What the business gets
1. Language-barrier
removal
Exhibit explanations, chat and audio in the
visitor's language, almost any language via AI, 7
priority languages
Foreign and local visitors served without hiring
multilingual guides
2. Location confidence
Automatic exhibit detection; indoor/outdoor venue
map; find coffee, restaurant, parking, restrooms,
exits
Fewer lost visitors; better crowd and
dwell-time data
3. Local commerce
Relevant, labeled offers (artifacts, clothing, food);
in-app payment
New revenue stream: sponsored placements,
commissions, merchant listings
1.2 Reference scenario: Adwa Museum
• Visitor installs the app, picks a language, and enters the museum. The entrance beacon is detected.
• App says: "Hello Mr. X, welcome to Adwa Museum. From now on I will guide you." in the chosen language (text
and optional audio).
• At 5gna Ber the zone beacon triggers the exhibit card: history, images, audio guide, and AI Q&A.; At 6gna Ber
the next zone content loads.
• At a warriors-history zone a Sponsored card may offer related artifacts or traditional clothing with seller
location, price and a pay button.
• After a long dwell time the app politely asks: "Would you like to see places to eat or rest nearby?" and shows the
nearest options on the venue map.
• Throughout, the visitor can open the venue map to find coffee, restaurant, parking, restrooms and exits with
walking directions.
2. Main features and launch priority
Honest scope note. The launch date is October 31, three days from this document. A credible MVP can contain all pillars
end-to-end, but each integration (real beacons, speech, payments, partner ad feeds) must be tested before it is advertised.
Items marked P0 must work on October 31; P1 should be demo-able; P2 follows after launch.
ID
Feature
Priority
Launch status rule
F1
Multilingual guide: any language via AI; 7
priority languages
P0
English + Amharic human-reviewed; Arabic, French,
Oromo, Tigrinya, Somali AI + spot-check; all others on
demand, labeled
F2
BLE beacon detection (foreground) with
entrance welcome
P0
Needs 3+ real beacons tested at venue; simulator for
demo/backup
F3
Zone/exhibit content cards (text, images,
audio)
P0
Content for every beacon zone loaded in admin
F4
Venue map + facility finder (coffee, food,
parking, restrooms, exits)
P0
Adwa Museum facilities surveyed and entered

<!-- page 3 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 3
Confidential - Negarit AI team
ID
Feature
Priority
Launch status rule
F5
AI chat guide grounded in venue knowledge
(RAG)
P0
Must cite venue sources; refuse when unsure
F6
Login, profile, language and interests
P0
Email/phone OTP + guest mode
F7
Sponsored cards and location-based
recommendations
P1
Clearly labeled; merchant-approved content only
F8
Payments: Chapa and Telebirr checkout
P1
Enable per provider only after sandbox + merchant
approval pass
F9
Context-aware refreshment suggestion (time
and dwell based, opt-in)
P1
Ask, never assume
F10
Voice input (speech-to-text) and narration
(text-to-speech)
P1
Per-language availability table must be honored
F11
NFC tap and compatible RFID reader support
P1
Phone NFC at launch; external UHF reader later
F12
Background beacon notifications
P2
Not advertised until tested on real Android and iOS
devices
F13
Personalized itineraries and route planning
P1
Time-boxed visit plans from interests
F14
Offline packs (content, audio, map tiles per
venue)
P1
Download per venue and language
F15
Admin and merchant dashboard (web)
P0
minimal
Beacon-zone mapping, content, ads, analytics
F16
Telebirr Remit
P2
Validate separately; see section 9
3. Users and roles
Role
Description
Key capabilities
Visitor
Tourist or local using the app
Guided visit, chat, map, offers, purchases, favorites, offline
packs
Guest
Visitor without account
Guided visit and map; no purchases or saved history
Venue admin
Museum or park staff
Manage venues, zones, beacons, content, facilities,
announcements
Merchant
Local seller or restaurant
Manage listings, offers, price, stock, orders, payouts
Content
translator/reviewer
Language expert
Review AI translations, mark as human-verified
Super admin
Negarit AI operations
Tenants, roles, ad policy, audit logs, analytics
4. Multilingual requirements (core differentiator)
4.1 Language strategy
Language is a first-class concept across the entire product: UI strings, exhibit content, AI answers, audio, ads and
receipts. Every content item is stored per language, with a provenance flag so visitors can tell reviewed content
from machine translation.
Principle: any language, with priority languages done best. Because translation is AI-driven, Negarit AI is not
limited to a fixed list. A visitor can pick or search any language; the seven priority languages get the highest quality
and human review.

<!-- page 4 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 4
Confidential - Negarit AI team
Tier
Languages
Quality rule
Tier 1: priority,
human-reviewed
English, Amharic
All exhibits, facilities, welcome messages and
ads reviewed by a person before publishing; full
native audio
Tier 2: priority, AI +
spot-check
Arabic, French, Afaan Oromo, Tigrinya,
Somali
Pre-generated at publish time, reviewer queue
in admin, 'AI translated' badge until reviewed;
Arabic uses right-to-left layout
Tier 3: universal, on demand
Any other language the AI provider
supports (Chinese, Spanish, German,
Italian, Russian, Hindi, Turkish,
Portuguese, Swahili, Japanese, Korean
and many more)
Translated on first request, cached for
everyone, labeled 'AI translated - may contain
errors'; audio only if a voice exists, otherwise
text
4.1b How 'almost every language' works technically
• Language list is data, not code: a languages table (code, name, script, direction, STT/TTS availability, quality
tier). Adding a language needs no app release.
• Language picker shows the 7 priority languages first, then a searchable list of all others; device language is
auto-suggested.
• UI strings: priority languages ship in the app; other languages get UI strings machine-translated once, cached
on the server and downloaded, with English fallback for any missing string.
• Exhibit content and AI answers are generated in the chosen language from the same verified source text, so
facts stay consistent across languages.
• Cost control: translate once per content item and language, cache by version, pre-generate Tier 2 at publish
time, and pre-warm Tier 3 languages seen in analytics.
• Quality ladder shown to the visitor: Human-reviewed, AI-translated (reviewed sample), AI-translated
(unreviewed).
• Low-resource languages are the weakest: the app always lets the visitor view the English original beside the
translation.
4.2 Functional requirements
• FR-L1 First-run language picker; device language suggested; changeable any time without restart.
• FR-L2 All UI strings externalized (Flutter localization files); RTL support for Arabic.
• FR-L3 Exhibit and facility content stored per language; any missing translation is generated on demand for any
supported language, cached, and flagged as AI-generated.
• FR-L4 AI chat answers in the visitor's language regardless of the language of the question or sources.
• FR-L5 Audio narration uses text-to-speech where the provider supports the language; otherwise the app shows
text and says audio is unavailable. A supported-language matrix is kept in config, not assumed.
• FR-L6 Speech input uses speech-to-text with a per-language availability check; fallback to typed input.
• FR-L7 Live phrase translation: visitor can speak or type a phrase for a vendor or staff member and show the
translated text on screen.
• FR-L8 Translation cache keyed by content id + language + version so repeated visits are instant and work
offline.
• FR-L9 Prices and dates shown in local formats; currency ETB with optional display conversion marked as
approximate.
Quality risk: translation, speech-to-text and text-to-speech quality varies a lot by language and provider. Tigrinya, Afaan Oromo
and Somali need native-speaker testing. In the store listing say priority languages for the 7 tested ones and many more
languages via AI for the rest, rather than promising equal quality everywhere.
5. BLE-first location engine

<!-- page 5 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 5
Confidential - Negarit AI team
5.1 How it works
• Each venue has an entrance beacon and one beacon per zone (for example 5gna Ber, 6gna Ber, cafe,
parking, restrooms).
• Beacons broadcast iBeacon (UUID, major, minor) or Eddystone frames. UUID identifies the Negarit network,
major the venue, minor the zone.
• The app ranges beacons, smooths RSSI, and emits an enter event when a zone's beacon is stable above its
threshold for N seconds.
• A cooldown prevents repeated triggers; exit uses a lower threshold (hysteresis) so the app does not flicker
between neighbors.
• The nearest-beacon result is cached content first, then enriched by AI when online.
5.2 Requirements
ID
Requirement
FR-B1
Request Bluetooth and location permissions with a plain-language explanation; handle denial gracefully with manual
'I'm at...' selection.
FR-B2
Foreground ranging on Android and iOS; background monitoring is P2 and must be tested per OS.
FR-B3
Welcome flow on entrance beacon: greeting with visitor name, venue intro, language confirmation, start guided
mode.
FR-B4
Zone trigger: show exhibit card, optional auto-play narration (setting), related facilities nearby, optional sponsored
card.
FR-B5
Smoothing (moving average or Kalman), min dwell 3 s, cooldown 5 min per zone (configurable),
strongest-stable-beacon wins.
FR-B6
Beacon registry in backend: id, venue, zone, UUID/major/minor, position, battery, last seen, calibration RSSI at 1 m,
status.
FR-B7
Simulation mode: clearly labeled developer/demo toggle with virtual beacons so the whole journey works without
hardware.
FR-B8
Fallback triggers: QR code per zone and NFC tap, and manual zone selection from the map.
FR-B9
Telemetry: anonymized zone-enter events and dwell time for analytics; no precise tracking without consent.
BLE signal strength gives approximate proximity, not exact indoor position. Walls, crowds and phone orientation change
readings. Plan an on-site calibration pass at Adwa Museum before launch and place beacons at least a few meters apart for
distinct zones.
6. Venue wayfinding and facility finder
This directly addresses the Adwa Museum experience where visitors could not find coffee, restaurants, parking or
exhibit areas.
• FR-W1 Venue model: venue > areas/floors > zones > points of interest (POI) with category, coordinates,
opening hours, photos and accessibility notes.
• FR-W2 Categories: exhibit, coffee, restaurant, parking, restroom, exit, entrance, shop, first aid, prayer room,
ATM, information desk, accessible route.
• FR-W3 Interactive map screen (see reference image 1) with pins by category, filter chips, 'near me', search, and
route lines between stops.
• FR-W4 Map foundation: Google Maps or Mapbox for outdoor and parking; for indoors, a venue floor-plan image
overlay with POI pins aligned to coordinates. Indoor accuracy comes from beacon zones, not GPS.
• FR-W5 'Where is the nearest coffee/restaurant/parking/restroom?' answered by both buttons and AI chat,
showing distance, walking time and a map pin.
• FR-W6 Turn-by-turn style guidance: zone-to-zone step list ('Exit this hall, turn left toward 6gna Ber') authored
per venue; map polyline for outdoor legs.

<!-- page 6 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 6
Confidential - Negarit AI team
• FR-W7 Venue map data editable in admin without an app release; downloadable for offline use.
• FR-W8 Accessibility: step-free route flag, large-text mode, screen-reader labels.
7. AI guide, recommendations and context awareness
7.1 AI features
Feature
Requirement
Smart tour guide
On zone enter, generate or load a story for the exhibit in the visitor's language, grounded in
venue-approved content.
AI chat (RAG)
Retrieve passages from the venue knowledge base (pgvector); answer with source references; say
'I don't have verified information' when retrieval is weak.
Voice guide
Narrate answers and exhibit stories via text-to-speech; speech-to-text for questions.
Personalization
Interests, time available, accessibility needs, previously visited zones (with permission).
Smart itinerary
Build a route through zones that fits the visitor's time, with breaks.
Context suggestions
Suggest nearby exhibits and facilities based on current zone and time.
Safety
No invented history: cite sources, flag uncertainty, rate-limit, moderate inputs, keep API keys on the
server.
7.2 Refreshment and rest suggestions
The idea is to help visitors who may be tired or hungry. Requirements:
• FR-C1 Triggers: time of day (meal windows), total visit duration, long dwell without movement, optional user tap
on 'I need a break'.
• FR-C2 The app asks: 'Would you like to see places to eat, drink or rest nearby?' and only then shows nearest
coffee, restaurants and seating with distance and hours.
• FR-C3 Visitor can snooze or disable these prompts in settings; at most one prompt per hour by default.
Design decision on voice-based inference: detecting tiredness or hunger from how loudly or softly someone speaks is
unreliable and would require continuous microphone access, which is a privacy problem and likely to be rejected by app stores.
Negarit AI uses opt-in signals (time, dwell, taps, and an explicit voice command like 'I'm hungry') instead. If you later want
voice-tone analysis, treat it as a separate, consent-based research feature.
8. Advertising and recommendation engine
8.1 Behavior
• FR-A1 Ads and offers attach to zones (beacon-triggered), categories (e.g., warriors history), and visitor
interests.
• FR-A2 Example: at 5gna Ber, warriors history content may show a Sponsored card for traditional clothing or
artifacts: image, seller name, shop location on the venue map, price in ETB, and Buy/Reserve/Directions
buttons.
• FR-A3 All paid placements display a visible Sponsored label; merchant identity and price are mandatory fields.
• FR-A4 Never show an ad over safety information, directions or while narration is mid-sentence; ads appear after
the exhibit story or as an inline card.
• FR-A5 Frequency caps (default: 1 sponsored card per zone visit, max 4 per hour), user can hide a merchant or
category.
• FR-A6 Merchant dashboard: create offers, upload images, set zones and schedule, view impressions, taps,
reservations and sales.
• FR-A7 Ad ranking: relevance (zone and category match), recency, merchant quality score, and bid/priority;
always explainable ('Why am I seeing this?').

<!-- page 7 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 7
Confidential - Negarit AI team
• FR-A8 Zemen Gebeya (and similar marketplaces) integration: product feed import or deep link into the partner
product page. Requires a partnership agreement and technical access; until confirmed, implement a generic
marketplace connector interface plus manual product entry.
• FR-A9 Analytics: impressions, taps, conversions per zone, per merchant, per language, visible in admin.
8.2 Recommendation sources
Signal
Use
Current zone and neighboring zones
Next exhibit, nearby facility
Interests chosen in onboarding
Rank exhibits and offers
Time available
Short vs full-route itinerary
Language and nationality (optional)
Cultural context, currency display
Visit history (consented)
Avoid repeats, personalize
9. Payments and commerce
Provider
Intended use
Status and rule
Chapa
In-app checkout for products and
services
Use Chapa's official API with sandbox first; hosted checkout or
in-app webview; webhook verification required before marking paid.
Telebirr
Mobile-money checkout for local
buyers
Requires merchant onboarding with Ethio telecom; integrate
through the official merchant/H5 or app-pay API once credentials
are issued.
Telebirr Remit
Overseas-sourced funds for local
recipients
This is a remittance product, not obviously a visitor checkout
method. Confirm with Ethio telecom whether any
merchant-payment use exists before building; treat as P2 and do
not advertise at launch.
Reserve / pay at
shop
Fallback for any offer
Visitor reserves the item and pays at the merchant's location;
always available.
• FR-P1 Order flow: cart > create order (server) > payment session > provider checkout > webhook > server
verification > receipt (in visitor's language).
• FR-P2 Idempotency keys, amount and currency verified server-side, signature verification on every webhook,
full audit log.
• FR-P3 The app never handles card numbers or mobile-money PINs; payment happens on the provider's
screen.
• FR-P4 Merchant payouts and platform commission are tracked in a ledger; reconciliation report in admin.
• FR-P5 Refund/dispute record; support contact on every receipt.
• FR-P6 Feature flags per provider so launch can enable only what is verified.
Launch rule: if Chapa or Telebirr merchant credentials are not approved and sandbox-tested by October 30, ship the app with
Reserve / pay at shop and show payment providers as 'coming soon' rather than presenting a button that fails.
10. NFC and RFID
• FR-N1 NFC tag/card read through phone NFC (Android first; iOS Core NFC for supported tag types) to open an
exhibit, validate a visitor pass, or add a stamp to a visit passport.
• FR-N2 Card UID or tag payload is a lookup key only; the backend validates it. Do not trust the UID as proof of
identity.
• FR-N3 Long-range UHF RFID needs an external reader over Bluetooth/USB; implement an adapter interface
and enable it once a reader model is chosen.
• FR-N4 Same event pipeline as beacons: all triggers (BLE, NFC, QR, manual) produce a uniform 'zone_event'.

<!-- page 8 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 8
Confidential - Negarit AI team
11. Screens and UI/UX design system
11.1 Visual direction (from the two reference images)
• Airy light-blue sky gradients and soft cloud backgrounds on hero and AI screens; white rounded cards with
gentle shadows.
• Vivid royal blue (#0B4DFF) as primary action and AI identity (the sparkle-in-circle AI avatar, blue send button,
blue user chat bubbles); light gray assistant bubbles.
• Large photographic destination cards (reference 1): hero photo with floating round icon buttons (back, search,
favorite, share), a 'Play audio' pill, a 'Map' pill, then title, stat chips (distance, time, stops) and a horizontal stop
carousel.
• Map (reference 1): rounded circular photo pins, blue route line with numbered stops, floating layer and locate
buttons, bottom sheet with stop cards.
• AI home (reference 2): centered AI avatar, greeting 'Hi {name}, how can I help you?', suggestion chips,
'Suggested for you' cards, pill input with mic and round blue send button.
• Bottom navigation: Explore, Map, Favorites, Profile (plus AI guide as a center action).
Token
Value
Primary
#0B4DFF
Primary dark
#0836B8
Sky background
#EAF2FF to #CFE3FF gradient
Surface
#FFFFFF, radius 20-24
Text
#14213D / secondary #5B6475
Success / Warning / Error
#1FA971 / #F5A524 / #E5484D
Sponsored label
Amber outline chip, always visible
Typography
Inter or Plus Jakarta Sans; Noto Sans Ethiopic for Amharic/Tigrinya; Noto Naskh Arabic
11.2 Screen list
Area
Screens
Onboarding
Splash, language picker, permissions primer (Bluetooth, location, notifications, microphone), interests
Auth
Sign in, sign up, OTP, guest mode, forgot access
Home / Explore
Greeting, current venue card, 'Start guided tour', nearby exhibits, suggested for you, language chip
Guided mode
Welcome overlay, current zone card, audio player, 'Ask AI', next-stop hint, nearby facilities
Venue map
Map with category filters, route, bottom sheet, 'nearest coffee/food/parking/restroom'
Exhibit detail
Hero image, story, audio, gallery, sources, related items, sponsored card slot
AI chat
Home with suggestions, chat with voice input, source chips, language switch
Itinerary
Pick time and interests, route preview, stops list, progress
Shop
Offer list, offer detail, cart, checkout, order status, receipts
Profile
Language, interests, favorites, history, privacy controls, offline packs, support
Admin web
Venues, zones, beacons (with simulator and battery view), POIs, content and translations, merchants,
offers, orders, analytics
12. System architecture

<!-- page 9 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 9
Confidential - Negarit AI team
Flutter app (Android first, iOS ready)
  BLE engine | NFC/QR | Map | Audio | Chat | Offline cache (Drift/SQLite)
        |  HTTPS REST + WebSocket (events)
NestJS API (modular monolith)
  auth | venues | zones/beacons | content+i18n | wayfinding | ai-gateway
  recommendations | ads | commerce | payments | notifications | analytics | admin
        |
PostgreSQL (PostGIS + pgvector)   Redis (cache, rate limit)   Object storage (images, audio)
        |
AI providers (LLM, embeddings, STT, TTS, translation)  -- keys only on server
Payment providers (Chapa, Telebirr)  -- webhooks to API
Admin/Merchant web dashboard (React or Next.js)
Layer
Choice
Notes
Mobile
Flutter, Riverpod or Bloc, go_router, Dio, Drift
BLE plugin chosen after compatibility check (e.g.,
flutter_blue_plus for raw BLE or a maintained iBeacon
plugin)
Backend
NestJS, TypeScript, TypeORM or Prisma,
class-validator, OpenAPI
Modular monolith for speed of delivery
Database
PostgreSQL 16, PostGIS, pgvector
Spatial queries for POIs, vectors for RAG
AI
Provider-abstraction layer (LLM, embeddings,
STT, TTS, translation)
Swap providers per language quality
Infra
Docker Compose locally; cloud VM or managed
services; GitHub Actions CI
Sentry and Firebase for monitoring/push
13. Data model (core entities)
Entity
Key fields
users
id, name, email/phone, role, preferred_language, interests[], consent flags, created_at
venues
id, slug, name_i18n, location (geography), timezone, opening_hours, floorplan_url, status
zones
id, venue_id, type (entrance/exhibit/facility), name_i18n, order, polygon, parent_zone_id
beacons
id, venue_id, zone_id, protocol, uuid, major, minor, tx_power, rssi_at_1m, battery, last_seen,
status
pois
id, venue_id, zone_id, category, name_i18n, location, hours, accessibility, photos[]
content_items
id, zone_id, type (story/audio/image), base_language, status
content_translations
content_id, language, text, audio_url, provenance (human/ai), reviewed_by, version
knowledge_chunks
id, venue_id, source_id, language, text, embedding vector, citation
visits
id, user_id, venue_id, started_at, ended_at
zone_events
id, visit_id, zone_id, source (ble/nfc/qr/manual), rssi_avg, entered_at, dwell_s
chat_sessions / messages
id, visit_id, role, text, language, sources[]
merchants
id, name, contact, venue_id, location, status, payout_account_ref
offers
id, merchant_id, title_i18n, price_etb, image, zone_ids[], categories[], schedule, is_sponsored,
status
orders / payments
id, user_id, offer_id, qty, amount, currency, provider, provider_ref, status, idempotency_key,
webhook_log
ad_events
id, offer_id, zone_id, type (impression/tap/conversion), at
audit_logs
id, actor, action, entity, before/after, at
14. API overview

<!-- page 10 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 10
Confidential - Negarit AI team
Area
Endpoints
Auth
POST /auth/otp/request, /auth/otp/verify, /auth/guest, POST /auth/refresh, GET /me, PATCH /me
Venues
GET /venues, GET /venues/:id, GET /venues/:id/zones, GET /venues/:id/pois?category=, GET
/venues/:id/offline-pack?lang=
Beacons
GET /venues/:id/beacons (public config), POST /events/zone, admin CRUD /admin/beacons
Content
GET /zones/:id/content?lang=, POST /content/translate (admin), PATCH /content/:id/review
AI
POST /ai/chat (stream), POST /ai/stt, POST /ai/tts, POST /ai/itinerary, GET /ai/suggestions?zone=
Wayfinding
GET /venues/:id/nearest?category=&zone;=, GET /venues/:id/route?from=&to;=
Offers
GET /offers?zone=〈=, POST /offers/:id/impression, POST /offers/:id/tap, merchant CRUD /merchant/offers
Commerce
POST /orders, POST /payments/chapa/session, POST /payments/telebirr/session, POST /webhooks/chapa,
/webhooks/telebirr, GET /orders/:id
NFC
POST /nfc/resolve (tag payload to zone/pass)
Admin
/admin/venues, /admin/zones, /admin/pois, /admin/merchants, /admin/analytics, /admin/audit
15. Non-functional requirements
Area
Requirement
Performance
Zone card visible within 1.5 s of beacon enter using cached content; AI first token under 3 s on normal 4G
Offline
Venue pack (content, images, audio, map data, POIs) per language; guided mode works without internet
except live AI and payments
Security
HTTPS only, JWT with refresh rotation, role-based access, rate limiting, input validation, secrets in
env/secret manager, no AI keys in the app, OWASP review
Privacy
Explicit consent for location/Bluetooth/analytics; no continuous microphone; data export and delete;
minimal data retention; privacy policy and terms in app
Reliability
Health checks, structured logs, Sentry, daily DB backups, graceful degradation when AI is down (show
cached content)
Accessibility
Dynamic text size, contrast AA, screen-reader labels, step-free route option
Compatibility
Android 8+ first; iOS 15+ afterwards; BLE and NFC feature checks with graceful fallback
Battery
Adaptive scanning (slower scan when stationary), pause outside venue geofence
Content integrity
AI answers must cite venue sources; human review before publishing Tier 1 content
16. PC environment: audit and installation
The Cursor agent must audit first, install second. For every tool: check if present and its version, report, then
install only what is missing or incompatible, asking before anything large or system-wide.
Tool
Check command
Install guidance (Windows 10/11)
Git
git --version
Git for Windows
VS Code
code --version
VS Code + Flutter and Dart extensions (Cursor is also
acceptable as editor)
Flutter SDK
flutter --version; flutter doctor -v
Official Flutter SDK zip, add to PATH; Dart is bundled
JDK 17
java -version
Temurin/OpenJDK 17; set JAVA_HOME
Android command-line
tools
sdkmanager --list
No Android Studio needed: install cmdline-tools, platform-tools,
one platform and build-tools; set ANDROID_HOME and PATH;
flutter doctor --android-licenses
ADB and phone
adb devices; flutter devices
Enable Developer options and USB debugging on the phone;
use a data cable

<!-- page 11 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 11
Confidential - Negarit AI team
Tool
Check command
Install guidance (Windows 10/11)
Node.js LTS + npm
node -v; npm -v
Node.js LTS
NestJS CLI
nest --version
npm install -g @nestjs/cli
PostgreSQL + pgAdmin
psql --version
PostgreSQL 16; add PostGIS via Stack Builder; pgvector via
build or Docker image
Docker Desktop
(optional)
docker --version
Recommended for Postgres with PostGIS and pgvector (e.g., a
pgvector/postgis image) if RAM is 8 GB or more
Python 3.11+ (optional)
python --version
Only if a separate AI/ETL service is added
Postman or Bruno
-
API testing
If the PC cannot run the Android toolchain, use flutter run -d chrome for UI work and a cloud build (e.g., GitHub Actions
building an APK) to install on the phone. Real BLE and NFC must still be tested on a physical Android device. Disk: plan for
30-50 GB free; RAM 8 GB works with a physical phone, 16 GB is better.
17. Testing and acceptance criteria
ID
Scenario
Pass condition
AT-1
Fresh install, language picked, guest sign-in
Reaches Home in under 60 s; chosen language applied
everywhere
AT-2
Entrance beacon (real or simulated)
Welcome message with visitor name and venue name in chosen
language, once per visit
AT-3
Walk 5gna Ber to 6gna Ber
Correct exhibit card at each zone, no flicker, no duplicate triggers
within cooldown
AT-4
Ask AI a question in Arabic about an exhibit
documented in English
Answer in Arabic with a source reference; unknown questions get a
'not verified' response
AT-5
'Where is the coffee / parking / restroom?'
Correct POI, distance, map pin and route
AT-6
Sponsored card at warriors zone
Labeled Sponsored, shows seller, price, map location; frequency
cap respected
AT-7
Pay with Chapa/Telebirr sandbox (if enabled)
Order marked paid only after verified webhook; receipt generated;
double-submit does not double-charge
AT-8
Long dwell and meal time
One polite refreshment prompt; snooze works; nothing shown if
disabled
AT-9
Airplane mode after downloading venue pack
Guided mode and map work; AI and payment show clear offline
notices
AT-10
Bluetooth off or permission denied
App explains and offers manual zone selection
AT-11
Screen locked / app minimized
Documented behavior; no promise of background detection unless
verified
AT-12
Admin changes a zone's text or an offer price
Change reflected in the app without a release
18. Three-day launch plan (October 28 to 31)
Day
Goal
Deliverables
Oct 28 (today)
Foundation
Environment audit and installs; monorepo (mobile, api, admin); DB schema and
seed for Adwa Museum; auth; Flutter theme, navigation and localization skeleton;
beacon simulator
Oct 29
Core journey
BLE engine with real beacons; welcome flow; zone cards; venue map and facility
finder; AI chat with RAG on seeded Adwa content; Tier 1 translations; admin for
zones/POIs/content

<!-- page 12 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 12
Confidential - Negarit AI team
Day
Goal
Deliverables
Oct 30
Commerce and polish
Offers and sponsored cards; Chapa/Telebirr sandbox or reserve-and-pay fallback;
refreshment prompt; audio narration; offline pack; NFC/QR fallback; on-site beacon
calibration; bug fixing on real phones
Oct 31
Release
Release APK/AAB, privacy policy, store listing or direct APK distribution, smoke test
at the venue, monitoring on, rollback plan, demo script
• Parallelize: one person on beacon + Flutter, one on backend + DB, one on AI + translations, one on admin +
content entry, one on payments + merchants, one on design QA.
• Freeze features at end of Oct 30. Oct 31 is for testing, fixes and release only.
• Collect Adwa Museum content (descriptions, images, facility list and locations, opening hours) today; content,
not code, is usually the real bottleneck.
19. Risks and open questions
Risk / question
Mitigation
Real beacon behavior differs from simulation
On-site calibration; manual and QR fallbacks; simulator for demos
Background detection is restricted on iOS and Android
Foreground first; document limits; test before claiming
Translation and TTS quality for Ethiopian languages
Native-speaker review; provenance badges; supported-language
matrix
Merchant credentials (Chapa, Telebirr) not ready
Feature flags, reserve-and-pay fallback
Telebirr Remit scope unclear
Validate with Ethio telecom; exclude from launch
Zemen Gebeya integration access
Generic connector + manual import; pursue partnership in parallel
Content accuracy and licensing for the museum
Written approval from the museum; cite sources; human review
Privacy and app-store policy (location, Bluetooth,
microphone)
Consent screens, minimal permissions, privacy policy
Open: Which beacon hardware and how many? Which
phones for testing? Is the museum granting installation
approval?
Confirm today

<!-- page 13 -->

NEGARIT AI  |  Software Requirements Specification v2.0
Page 13
Confidential - Negarit AI team
20. Cursor Agent master prompt
Paste everything in the box below into a new Cursor Agent task, together with this PDF.
ROLE
You are the lead engineer for Negarit AI, a multilingual, BLE-beacon-triggered visitor companion
   and
local-commerce app. Implement it from the attached SRS v2.0. Quality over speed, but the MVP
   launches
on October 31, 2026, so build the end-to-end visitor journey first.
RULES
1. PHASE 0 - AUDIT (no changes yet): inspect the repo and this Windows PC. Report a table of
   every tool
   in SRS section 16: installed? version? action needed. Also list existing code you will
      preserve.
   Ask for approval before installing anything large or system-wide.
2. PHASE 1 - ENVIRONMENT: install only what is missing. Do NOT install Android Studio. Use VS
   Code or
   Cursor, Flutter SDK, JDK 17, Android command-line tools, Node LTS, NestJS CLI, PostgreSQL
   (+PostGIS, pgvector, or use Docker). Run flutter doctor -v, flutter devices, node -v, psql
      --version
   and fix issues. If the PC cannot run the Android toolchain, use flutter run -d chrome and set
      up a
   GitHub Actions APK build.
3. PHASE 2 - SCAFFOLD: monorepo with /mobile (Flutter), /api (NestJS), /admin (web dashboard),
   /docs.
   Docker Compose or local Postgres, env templates (.env.example, never commit secrets),
      migrations,
   seed data for Adwa Museum (venue, entrance, 5gna Ber, 6gna Ber, coffee, restaurant, parking,
   restrooms, exits, sample merchants and offers) in English and Amharic.
4. PHASE 3 - FEATURES in this order, testing each before moving on:
   a) Auth (OTP + guest), profile, language picker, full localization incl. RTL for Arabic.
   b) Beacon engine (smoothing, hysteresis, cooldown) + SIMULATION MODE + QR/NFC/manual
      fallbacks.
   c) Welcome flow and zone content cards with audio.
   d) Venue map and facility finder (nearest coffee/food/parking/restroom) with routes.
   e) AI gateway: provider abstraction, RAG over pgvector, source citations, multilingual
      answers,
      STT/TTS with a per-language availability matrix, graceful fallback when AI is down.
   f) Offers and Sponsored cards with frequency caps and a visible Sponsored label.
   g) Payments: Chapa and Telebirr behind feature flags, server-side verification, signed
      webhooks,
      idempotency, plus a Reserve / pay-at-shop fallback. Telebirr Remit is NOT implemented at
         launch.
   h) Refreshment prompt (time/dwell based, opt-in, asks before showing).
   i) Offline venue packs. j) Itinerary planner. k) Admin/merchant dashboard and analytics.
5. UI/UX: follow SRS section 11: light-blue airy backgrounds, royal blue #0B4DFF primary, white
   rounded
   cards, circular photo map pins with blue route lines, floating round icon buttons, 'Play
      audio' and
   'Map' pills, AI sparkle avatar, suggestion chips, pill input with mic and round blue send
      button.
6. SECURITY/PRIVACY: no API keys in the app, JWT + refresh rotation, RBAC, validation, rate
   limits,
   consent screens, no continuous microphone, no card or PIN handling in the app.
7. HONESTY: never fake a capability. Anything unverified (real beacons, background scanning,
   speech in a
   language, payment provider) must be behind a flag and clearly labeled in the UI and in a
   docs/STATUS.md that lists what is verified vs simulated.
8. TESTING: unit tests for the beacon engine and payment verification, API e2e tests, and the
   acceptance tests AT-1..AT-12 as a manual checklist in docs/ACCEPTANCE.md.
9. WORKFLOW: small commits, a plan before each phase, summarize results after each phase, and
   stop to
   ask me when a decision depends on credentials, hardware or content I must provide.
FIRST ACTION: run PHASE 0 only and report.
