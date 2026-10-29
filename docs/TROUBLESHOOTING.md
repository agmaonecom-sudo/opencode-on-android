# مشاكل شائعة

## التثبيت

**`ERROR: Run this inside Termux (F-Droid build)`**
انت شغّال في تطبيق تاني أو في نسخة Google Play القديمة. نزّل Termux من F-Droid.

**`arm64 only`**
الجهاز 32-bit. المشروع محتاج arm64.

**فشل تحميل Ubuntu أو Node**
غالبًا النت قطع. شغّل `bash install.sh` تاني؛ الملفات الناقصة بتتحمّل من جديد.

**`npm` بيفشل عند بناء `node-pty` / `node-gyp`**
الأدوات الناقصة:

```bash
proot-distro login ubuntu -- bash -lc '
  apt-get update && apt-get install -y build-essential python3 &&
  npm i -g @openchamber/web@latest --no-audit --no-fund'
```

## التشغيل

**`Address already in use`**
البورت مشغول (نسخة قديمة شغالة أو تطبيق تاني):

```bash
bash stop.sh
# أو
PORT=40254 bash start.sh
```

**الواجهة بتطلب باسورد وأنا نسيته**

```bash
cat ~/.config/opencode-android/ui-password
```

أو امسح الملف وشغّل `start.sh` تاني.

**Termux بيتقفل / السيرفر بيموت لما الشاشة تتقفل**
- اقفل تحسين البطارية لتطبيق Termux من إعدادات أندرويد.
- سيب إشعار Termux شغال (ما تشيلوش).
- `start.sh` بيعمل wake-lock تلقائي.

**`npm` بيطلع تحذير `install-scripts ... node-pty`**
طبيعي ومش مشكلة: `node-pty` بيستخدم prebuilt جاهز لـ linux-arm64، والـ pty
متجرّب وشغال. سيب التحذير وكمل.

**`openchamber: command not found` جوه Ubuntu**
PATH مش متظبط في الجلسة دي. استخدم `bash -lc` بدل `bash`:

```bash
proot-distro login ubuntu -- bash -lc 'openchamber --version'
```

**مش عارف أوصل من الكمبيوتر على نفس الواي فاي**
- شغّل `START_LAN=1 bash start.sh`.
- هات IP الموبايل من `ip addr` أو إعدادات الواي فاي.
- افتح `http://<IP>:40253` من الكمبيوتر.
- لو مش شغال: الراوتر بيعزل الأجهزة (AP isolation) — جرّب hotspot من الموبايل.

## الأداء

**بطيء في أول تشغيل**
طبيعي: بناء `node-pty` وفتح المشروع أول مرة بياخد وقت.

**مساحة الجهاز خلصت**
`proot-distro remove ubuntu` يمسح كل حاجة جوه Ubuntu (بما فيها مشاريعك في
`/root/projects`) — انسخها الأول:

```bash
proot-distro login ubuntu -- tar -czf /root/projects-backup.tar.gz -C /root projects
```
