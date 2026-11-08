# Brand, design system, and voice (from chats)

Source: "Sprint Brand Guidelines v1.0" (a 9-section .docx generated in the 2026-06-10 chat) and the design-system Q&A before it.
The values in code are the truth: `lib/core/theme/app_colors.dart`, `app_typography.dart`, `app_spacing.dart`. This file explains the intent behind them.

## Decisions
- Primary: Sprint Green `#1B5E3B`. Accent: Lime `#CCF42B`. Dark base `#0D1B13`.
- Style: Rounded and Soft. Font: Cairo only.
- Dark and Light modes both supported with a user toggle. **Dark is the app default.** (Earlier prompts said "dark only"; the guidelines and the theme providers supersede that.)
- Logo: a standalone lightning-bolt icon (letter-mark approach) on a `#1B5E3B` rounded square, with a `#0D1B13` bolt. Four variants exist: Dark, Transparent, Lime Accent, Light Mode. Logo background is always `#1B5E3B`.
- Button styles: primary = green fill with lime text; secondary = green outline; accent = lime fill with green text.
- Image generators (Gemini, ChatGPT) gave poor logos; the logo was rebuilt by hand as SVG. Do not regenerate it with an image model.

## Brand checklist (before shipping any screen or component)
- All text is Cairo, no other font.
- Colors come from the design tokens only.
- Corner radius: 12px for buttons, 16px for cards.
- Spacing is multiples of 4px only.
- Messages are in Egyptian colloquial Arabic.
- Dark mode works and uses tokens.
- Semantic colors: green for success, yellow for warning, red for error.
- Every badge and status has its defined color from the badge table (confirmed, pending, cancelled, trainer, featured).
- A QR code is shown after every successful booking.

## Tone of voice
Personality: a capable friend who helps, not a formal system. Egyptian colloquial Arabic ("عامية مصرية"), light and warm.

| Situation | Formal (avoid) | Sprint voice |
|---|---|---|
| Load error | "حدث خطأ في تحميل البيانات" | "البيانات محملتش، جرب تاني بعد ثانية!" |

The full Do/Don't table (success, warning, empty states, etc.) is in the 2026-06-10 chat and in the Brand Guidelines .docx. Do not invent new copy styles; match the table.

## Note on Figma
The Figma build script in the 2026-06-09 chat loaded Inter as a placeholder font. The app itself uses Cairo. Do not copy Inter into Flutter.
