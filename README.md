# المستشار التعليمي الذكي

منصة Flutter/Firebase للإرشاد الأكاديمي: يسجل الطالب، يكمل ملفه، يجيب عن تقييمات منشورة، ويحصل على توصيات تخصصات قابلة للتفسير، ثم يتواصل مع مستشار تعليمي ويحجز موعدًا.

## الأدوار والتوجيه

`users/{uid}.accountType` هو المصدر الوحيد للدور: `student` و`advisor` و`admin`. بوابة التطبيق توجه الطالب إلى رحلة الطالب، والمستشار غير المعتمد إلى المراجعة، والمستشار المعتمد إلى طلباته، والمدير إلى لوحة الإدارة. لا يظهر إنشاء مدير في التسجيل العام.

## إنشاء أول Admin بأمان

1. أنشئ `admin@gmail.com` عبر **Firebase Authentication Console** بكلمة مرور قوية مختلفة عن البريد ولا تضعها في Git.
2. انسخ UID، ثم أنشئ `users/{uid}` في Firestore بالقيم: `accountType: "admin"` و`isActive: true` و`email: "admin@gmail.com"`.
3. سجّل الدخول بنفس بيانات Firebase Authentication. التطبيق يتحقق من الدور قبل فتح لوحة الإدارة، كما تطبق قواعد Firestore حماية المدير.

لا ينشئ التطبيق حساب المدير تلقائيًا، ولا تحتوي ملفات المصدر على أي بيانات دخول أو أسرار.

## Collections

`users`, `students`, `advisors`, `majors`, `assessments`, `assessment_results`, `recommendations`, `consultations`, `appointments`, `appointment_slots`, `conversations`, `messages`, `notifications`, و`calls`.

## إعداد الخدمات الخارجية

- استخدم `firebase_options.dart` المولّد عبر FlutterFire، ثم انشر `firestore.rules` و`storage.rules`.
- أضف إعدادات FCM في Firebase Console حسب Android/iOS.
- أضف App ID وtoken/App Sign الخاصين بـ ZEGOCLOUD في إعدادات البيئة أو Firebase Remote Config؛ لا تضع الأسرار في Git.
- أضف مفتاح مزود الذكاء الاصطناعي في بيئة آمنة أو Cloud Functions فقط.

## التشغيل

```bash
flutter pub get
flutter run
```
