# BEKBOLAT OS

A private, database-backed personal workspace. Vinext (Next.js App Router API), React, TypeScript, Tailwind and Cloudflare D1. Motion uses CSS transitions and respects reduced motion.

## Working MVP

- Dashboard with Aqtau clock, real event current/next state, today counters, Top 3, tomorrow and focus timer.
- School timetable and linked homework. No fabricated personal records.
- Goal → project → task, goal milestones and roadmap/vision views.
- After-school planner: school end + travel, task duration, fixed calendar blocks, breaks and protected sleep. Meals, FLL travel, training and sessions must currently be explicitly entered in Calendar. Overflow tasks are manually rescheduled.
- FLL missions, attempts, failure reasons, stability and session reviews.
- Workouts/exercises, portfolio entries, achievements, skills, calendar views, real activity totals and written reviews.
- CRUD, global search, quick capture review, 9-step setup, themes, keyboard dialog handling, responsive layout.

## Persistence and privacy

Separate normalized D1 tables and generated Drizzle migrations. APIs require platform-authenticated identity and scope all records to the visitor. Related IDs are checked for ownership. New entries are private. `/portfolio` returns only explicitly public project and achievement records; the deployed Site remains owner-private, so public flags curate that view without enabling internet sharing.

## Next modules

File/image uploads and galleries; session live mode; richer project milestones/files; parent-goal editor; pack checklist; configurable widget/layout/localization; training adaptation; automatic FLL travel/meal blocks; calendar drag-and-drop; annual reports. These are intentionally not represented as working controls.

## Development

`npm run dev`, `npm run db:generate`, `npm run build`.
Local D1 needs the generated migrations applied through Wrangler. Sites applies production migrations on deployment. Theme is the only localStorage preference; product data stays in D1.

## Local school timetable

Run the development server, then `python3 scripts/import-school-schedule.py` to apply `templates/school-schedule.json` to the local development account. The template has 42 lesson slots, uses «Основы права» and «Воркаут», and excludes the optional elective. It contains no user identity, teacher names or classroom locations. Existing lessons in matching weekday/time slots are updated; the script also removes the old «9 ЭЛ Олимп М» elective. Other personal records are untouched. Local database files stay outside Git.
