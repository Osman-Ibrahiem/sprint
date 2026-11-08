# Sprint — alignment with the registered research plan

Checked 2026-11-08 against two files from Dr. Sara El-Hag: the research plan registration form (25 pages) and a one-page problem statement. Key sections are transcribed in `thesis-research-plan.md` (same folder). Compared with the constitution (BR-01 to BR-07), CLAUDE.md and the project docs.

Title (AR): تطبيق إلكتروني لإدارة وتسويق المنشآت الرياضية بجامعة طنطا كنموذج تطبيقي للإدارة الإلكترونية
Title (EN): An electronic application for managing and marketing sports facilities at Tanta university as applied model of Electronic management

## Result
Nothing in the plan contradicts BR-01 to BR-07. The emphasis differs, and there are gaps and two points to confirm with the doctor.

## 1. Framing: management and marketing, not governance
- The plan talks about: marketing and promoting facilities, reaching target groups, using evening and holiday periods, accurate usage-rate data, revenue from electronic payment going to the college/university fund, less paper.
- The plan does not mention fairness, waitlist, crowding, trainers, QR tickets, capacity caps or asset custody (عهدة). These are Sprint additions. Not a conflict.
- Constitution BR-02 says fairness is "a core doctoral dissertation requirement". The registered plan does not say that. Confirm with the doctor or reword.

## 2. Gaps in the current feature set
- Marketing: only guest discovery and a "featured" badge exist. No offers, announcements or promotion of quiet hours. Biggest gap, since "marketing" is in the title.
- Usage rates: admin dashboard has KPIs, but must define utilization per facility and time, including idle hours.
- Evening and holiday periods: confirm the schedule and slots support them.
- Periodic maintenance: mentioned in the plan's introduction. Current scope has only damage reports in asset management; no maintenance scheduling.
- Revenue: finance/revenue screen exists; the plan mentions directing revenue to the college/university fund.

## 3. Users (confirm with the doctor)
- Research population: VP for community service and environment development, college deans and vice-deans, general manager of university youth care, directors of the higher youth-care committees, admins/specialists in the general administration and in college youth-care departments, heads of those departments, director and staff of the university stadium administration.
- Our admin hierarchy: facility manager, dean, ministry representative. "Ministry representative" is not in the population. Open questions: who actually manages each facility, and is the ministry in scope?
- Beneficiaries in the plan: students, employees, and members of the surrounding community. Matches BR-07 (discount for university-affiliated, full price for external).

## 4. Method and what it means for the build
- The app is the third research tool (with document analysis and a questionnaire). Its requirements are derived from questionnaire results and expert review (plan steps 6 and 18), so the current features are a first hypothesis.
- Proposed: trace each feature and BR to a questionnaire axis in the specs; treat BRs as revisable after expert review.
- Step 18 deliverables: app objectives and beneficiary groups, conceptual design of components/screens/services, database design, screens, programming, expert review. Figma and the specs cover part of this; a database design (ERD) is not done yet.

## Open questions for the doctor (sent as a message draft on 2026-11-08, no reply yet)
1. Is fairness (waitlist, equal access) a stated requirement of the dissertation? BR-02 claims so.
2. Is the ministry representative part of the admin hierarchy, and who is the real facility manager (stadium administration, youth-care department)?
3. Should marketing features be in scope (offers, announcements, quiet-hour promotion)?
4. Which usage-rate metrics does she want to report?
5. Is periodic maintenance scheduling expected?
6. Should each feature be linked to a questionnaire axis for traceability?
