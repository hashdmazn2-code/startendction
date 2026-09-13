# Smart Educational Advisor data migration

The existing Firebase integration is retained. New educational documents use the existing `users` identity document and role-based access, while feature data is stored by meaning rather than copied into parallel medical collections.

| Previous concept | Educational concept | Target collection / fields |
| --- | --- | --- |
| patient | student | `users.accountType: student`, `students/{uid}` |
| doctor and licence | educational advisor and qualifications | `users.accountType: advisor`, `advisors/{uid}`, `advisor_verification` storage path |
| medical specialty | academic major | `majors` |
| health assessment | educational assessment | `assessments`, `assessment_results` |
| medical consultation / appointment | educational consultation / appointment | `consultations`, `appointments` |

## Recommendation contract

`RecommendationService` is intentionally isolated from widgets and Firestore. It assigns a repeatable 100-point score: GPA 25, skills 25, interests 20, core subjects 15, abilities 10, and an assessment-field score up to 5. It excludes unpublished majors. The UI should obtain both profile and major records through `EducationalRepository`; no recommendation list is hardcoded.

## Security deployment

Deploy `firestore.rules` and `storage.rules` with the existing Firebase project after validating its current production rules. The rules limit student records to their owner, keep advisor verification uploads private, and permit consultation/conversation access only to participants or administrators.
