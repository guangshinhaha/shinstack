---
name: interaction-design
description: >
  Design and implement microinteractions, motion design, transitions, and user feedback
  patterns. Use when adding polish to UI interactions, implementing loading states, creating
  gesture-based interactions, designing hover/focus states, building notification/toast
  systems, adding scroll-triggered animations, implementing drag-and-drop, or creating
  delightful user experiences.
---

# Interaction Design

Create engaging, intuitive interactions through motion, feedback, and thoughtful state transitions.

## Project Conventions

- **Library:** use the animation library the project already has. With none and a React app, default to Framer Motion (Motion).
- **CSS animations:** Use `transform` and `opacity` only for 60fps performance
- **Springs:** only for drag with momentum, gestures that can be interrupted, and decorative pointer-tracking. Everything else uses the easing rules below.
- **Interruptible:** Users must be able to cancel or override any animation

### Should this animate at all?

How often will users see it? (Rules adapted from [emilkowalski/skills](https://github.com/emilkowalski/skills), MIT.)

| Frequency | Decision |
| --- | --- |
| 100+ times a day (keyboard shortcuts, command palette) | No animation. Never animate keyboard-initiated actions. |
| Tens of times a day (hover effects, list navigation) | Remove or cut hard |
| Occasional (modals, drawers, toasts) | Standard animation |
| Rare or first-time (onboarding, celebrations) | Can add delight |

Daily-use government tools sit in the top two rows. Default to none.

### Easing

- Never `ease-in` on UI: it starts slow, exactly when the user is watching. Default `ease-out`; `ease-in-out` for on-screen movement; `ease` for hover and colour; `linear` only for constant motion (progress).
- Built-in curves are weak. Use `cubic-bezier(0.23, 1, 0.32, 1)` for ease-out and `cubic-bezier(0.77, 0, 0.175, 1)` for ease-in-out.
- Keep UI under 300ms; modals and drawers up to 500ms. A 180ms dropdown feels faster than a 400ms one.
- Popovers scale from their trigger (`transform-origin`), modals stay centred. Never `scale(0)`: start at `scale(0.95)` with `opacity: 0`. Never `transition: all`.

### Timing Scale

| Duration  | Use Case                                  |
| --------- | ----------------------------------------- |
| 100-150ms | Micro-feedback (hovers, clicks)           |
| 200-300ms | Small transitions (toggles, dropdowns)    |
| 300-500ms | Medium transitions (modals, page changes) |
| 500ms+    | Complex choreographed animations          |

### Accessibility

Always respect `prefers-reduced-motion: reduce`. Set animation duration to 0 when the user prefers reduced motion. This is non-negotiable.

## Reference Files

Read these on demand based on the task:

| File | When to read |
|------|-------------|
| [animation-libraries.md](references/animation-libraries.md) | Choosing or configuring Framer Motion, GSAP, or CSS-based approaches |
