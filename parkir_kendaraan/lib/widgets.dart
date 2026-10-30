import 'package:flutter/material.dart';

import 'theme.dart';

enum Tone { success, warning, danger, info, neutral }

extension ToneX on Tone {
  Color get fg => switch (this) {
        Tone.success => AppColors.success,
        Tone.warning => AppColors.gold,
        Tone.danger => AppColors.danger,
        Tone.info => AppColors.gold,
        Tone.neutral => AppColors.muted,
      };

  Color get bg => switch (this) {
        Tone.success => AppColors.successSoft,
        Tone.warning => AppColors.goldSoft,
        Tone.danger => AppColors.dangerSoft,
        Tone.info => AppColors.goldSoft,
        Tone.neutral => AppColors.surfaceAlt,
      };
}

// ---------------------------------------------------------------------------
// Kartu & kotak
// ---------------------------------------------------------------------------

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Material(
      color: color ?? AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: borderColor ?? AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Kotak di dalam kartu (warna lebih terang dari kartu).
class InnerBox extends StatelessWidget {
  const InnerBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.color,
    this.borderColor,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return Material(
      color: color ?? AppColors.surfaceAlt,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: borderColor ?? AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip(this.label,
      {super.key, this.tone = Tone.neutral, this.dot = true});

  final String label;
  final Tone tone;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tone.bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tone.fg.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration:
                  BoxDecoration(color: tone.fg, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: tone.fg,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile(this.label, this.value,
      {super.key, this.caption, this.valueColor, this.dense = false});

  final String label;
  final String value;
  final String? caption;
  final Color? valueColor;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColors.muted, fontSize: dense ? 10.5 : 12.5)),
        SizedBox(height: dense ? 4 : 6),
        Text(
          value,
          style: TextStyle(
            fontSize: dense ? 22 : 28,
            fontWeight: FontWeight.w800,
            color: valueColor ?? AppColors.ink,
          ),
        ),
        if (caption != null) ...[
          const SizedBox(height: 2),
          Text(caption!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.muted, fontSize: 11)),
        ],
      ],
    );
    if (dense) {
      return InnerBox(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: content);
    }
    return AppCard(padding: const EdgeInsets.all(14), child: content);
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow(this.label, this.value,
      {super.key, this.bold = false, this.valueColor});

  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(label,
                style:
                    const TextStyle(color: AppColors.muted, fontSize: 13)),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                color: valueColor ?? AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteBanner extends StatelessWidget {
  const NoteBanner(this.text,
      {super.key, this.tone = Tone.info, this.icon = Icons.info_outline});

  final String text;
  final Tone tone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tone.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.fg.withAlpha(60)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: tone.fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.5, color: tone.fg, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar(this.initials, {super.key, this.radius = 20});

  final String initials;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.gold,
          fontWeight: FontWeight.w700,
          fontSize: radius * 0.7,
        ),
      ),
    );
  }
}

class PlateBadge extends StatelessWidget {
  const PlateBadge(this.plate, {super.key});

  final String plate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        plate,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Logo & header
// ---------------------------------------------------------------------------

/// Logo sederhana. Ganti dengan Image.asset('assets/logo.png') jika sudah ada file logonya.
class ParveLogo extends StatelessWidget {
  const ParveLogo({super.key, this.size = 34, this.showWord = true});

  final double size;
  final bool showWord;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.3),
            border: Border.all(color: AppColors.gold, width: 1.5),
          ),
          child: Text(
            'P',
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: size * 0.6,
            ),
          ),
        ),
        if (showWord) ...[
          const SizedBox(width: 8),
          Text(
            'PARVE',
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              fontSize: size * 0.4,
            ),
          ),
        ],
      ],
    );
  }
}

class BellButton extends StatelessWidget {
  const BellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => showInfo(context, 'Tidak ada notifikasi baru'),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surfaceAlt,
          border: Border.all(color: AppColors.border),
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.notifications_none, size: 20, color: AppColors.gold),
            Positioned(
              right: 9,
              top: 9,
              child: SizedBox(
                width: 7,
                height: 7,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: AppColors.gold, shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.place = 'Pacific Place',
    this.caption = 'Operasional parkir',
    this.onBack,
    this.online = false,
  });

  final String place;
  final String caption;
  final VoidCallback? onBack;
  final bool online;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          if (onBack != null)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: onBack,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.arrow_back_ios_new,
                      size: 16, color: AppColors.ink),
                ),
              ),
            ),
          const ParveLogo(size: 34, showWord: false),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5)),
                Text(caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.muted, fontSize: 11.5)),
              ],
            ),
          ),
          if (online)
            const StatusChip('Sistem online', tone: Tone.success)
          else
            const BellButton(),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.initials,
    required this.name,
    required this.subtitle,
    this.trailing,
  });

  final String initials;
  final String name;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Avatar(initials),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14.5)),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.muted, fontSize: 12)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tombol
// ---------------------------------------------------------------------------

enum ButtonKind { primary, outline, danger }

class AppButton extends StatelessWidget {
  const AppButton(this.label,
      {super.key,
      this.onPressed,
      this.icon,
      this.kind = ButtonKind.primary});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonKind kind;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
    const size = Size.fromHeight(50);
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    const text = TextStyle(fontWeight: FontWeight.w700, fontSize: 14);

    if (kind == ButtonKind.primary) {
      return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          minimumSize: size,
          shape: shape,
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.onGold,
          disabledBackgroundColor: AppColors.surfaceAlt,
          disabledForegroundColor: AppColors.muted,
          textStyle: text,
        ),
        child: content,
      );
    }
    // outline & danger: tombol gelap dengan teks terang (sesuai Figma)
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: size,
        shape: shape,
        backgroundColor: AppColors.surfaceAlt,
        foregroundColor: AppColors.ink,
        side: const BorderSide(color: AppColors.border),
        textStyle: text,
      ),
      child: content,
    );
  }
}

// ---------------------------------------------------------------------------
// Navigasi bawah
// ---------------------------------------------------------------------------

class NavItem {
  const NavItem(this.icon, this.label, {this.badge = false});
  final IconData icon;
  final String label;
  final bool badge;
}

class ParveNavBar extends StatelessWidget {
  const ParveNavBar({
    super.key,
    required this.index,
    required this.onTap,
    required this.items,
  });

  final int index;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => onTap(i),
                      child: _item(items[i], i == index),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(NavItem it, bool sel) {
    final color = sel ? AppColors.gold : AppColors.muted;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: sel ? AppColors.goldSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: sel ? AppColors.gold : Colors.transparent),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(it.icon, size: 22, color: color),
              if (it.badge)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.gold, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 3),
          Text(it.label,
              style: TextStyle(
                  fontSize: 11.5, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

void showInfo(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}