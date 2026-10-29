# OpenCode + OpenChamber على أندرويد — من غير تثبيت تطبيق

تشغيل وكيل برمجة كامل (OpenCode) مع واجهة ويب (OpenChamber) جوه تليفونك،
باستخدام Termux + Ubuntu. مفيش root، ومفيش APK، والواجهة بتفتح في المتصفح.

> مشروع مستقل، **غير تابع** لفريق OpenCode أو OpenChamber.
> الريبو ده مفيهوش أي كود من تطبيق «OpenCode – AI» الموجود على Google Play؛
> كل المكونات المستخدمة مفتوحة المصدر (راجع [NOTICE.md](NOTICE.md)).

## المتطلبات

| | |
|---|---|
| أندرويد | 8.0 أو أحدث، معالج **arm64** |
| مساحة فاضية | ~2 GB |
| الوقت | 10–15 دقيقة أول مرة |
| Termux | من [F-Droid](https://f-droid.org/packages/com.termux/) — **مش** نسخة Google Play |

## التثبيت

افتح Termux واكتب:

```bash
pkg update -y && pkg install -y git
git clone https://github.com/agmaonecom-sudo/opencode-on-android.git
cd opencode-on-android
bash install.sh
```

السكربت بيثبّت Ubuntu جوه Termux، وبعده Node.js 24 وOpenCode وOpenChamber.
لو قطعت النت في النص، شغّل `bash install.sh` تاني — بيكمّل من حيث وقف.

## التشغيل

```bash
bash start.sh
```

هيفتح المتصفح على `http://127.0.0.1:40253`، والباسورد هيظهر في الترمنال
(ومحفوظ في `~/.config/opencode-android/ui-password`).

سيب جلسة Termux مفتوحة وشغالة. `Ctrl+C` بيوقف السيرفر.

## الموديلات

- موديلات **OpenCode Zen** المجانية متاحة من غير أي مفتاح — زي `Big Pickle`
  و`GLM-5.3-Flash Free`. اختار الموديل من فوق في الشات.
- لمزوّد تاني (Anthropic / OpenAI / OpenRouter…):

```bash
proot-distro login ubuntu
opencode auth login
```

## الاستخدام اليومي

```bash
bash start.sh                 # تشغيل عادي (localhost بس)
START_LAN=1 bash start.sh     # متاح من الكمبيوتر على نفس الواي فاي
PORT=40254 bash start.sh      # بورت تاني
bash stop.sh                  # قفل سيرفر سايب
```

- **مشاريعك** جوه Ubuntu في `/root/projects` — تفتحها من الواجهة.
- **تحديث:**

```bash
proot-distro login ubuntu -- bash -lc 'npm i -g @opencode/cli@latest @openchamber/web@latest'
```

- **باسورد جديد:** امسح `~/.config/opencode-android/ui-password` وشغّل `start.sh` تاني.

## الأمان

- افتراضيًا السيرفر على `127.0.0.1` بس + باسورد عشوائي 32 حرف.
- `START_LAN=1` بيفتحه لكل الشبكة (الحماية = الباسورد). متستخدمهاش على واي فاي عام.
- كل حاجة بتشتغل جوه Ubuntu معزول في Termux — من غير root.

## مشاكل شائعة

راجع [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

## English quickstart

```bash
# Termux from F-Droid, arm64 device
pkg update -y && pkg install -y git
git clone https://github.com/agmaonecom-sudo/opencode-on-android.git
cd opencode-on-android && bash install.sh
bash start.sh            # opens http://127.0.0.1:40253
```

Requires ~2 GB free and 10–15 min on first install. Default bind is localhost
with a random UI password; `START_LAN=1 bash start.sh` exposes it to your LAN.

## الترخيص

MIT — راجع [LICENSE](LICENSE) و[NOTICE.md](NOTICE.md).
