# Graph Report - .  (2026-05-24)

## Corpus Check
- 139 files · ~105,235 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 427 nodes · 473 edges · 53 communities (44 shown, 9 thin omitted)
- Extraction: 88% EXTRACTED · 12% INFERRED · 0% AMBIGUOUS · INFERRED: 55 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Windows Runtime|Windows Runtime]]
- [[_COMMUNITY_Calendar Persistence|Calendar Persistence]]
- [[_COMMUNITY_Project Tooling|Project Tooling]]
- [[_COMMUNITY_Calendar Screen State|Calendar Screen State]]
- [[_COMMUNITY_macOS App Icons|macOS App Icons]]
- [[_COMMUNITY_Health Tracking Assets|Health Tracking Assets]]
- [[_COMMUNITY_Linux Runtime|Linux Runtime]]
- [[_COMMUNITY_Persistence Imports|Persistence Imports]]
- [[_COMMUNITY_Launcher Icons|Launcher Icons]]
- [[_COMMUNITY_Windows Windowing|Windows Windowing]]
- [[_COMMUNITY_Windows Build|Windows Build]]
- [[_COMMUNITY_Linux Build|Linux Build]]
- [[_COMMUNITY_App Root Injection|App Root Injection]]
- [[_COMMUNITY_Drift Generated Model|Drift Generated Model]]
- [[_COMMUNITY_SVG UI Widgets|SVG UI Widgets]]
- [[_COMMUNITY_Web Manifest|Web Manifest]]
- [[_COMMUNITY_Theme And Bootstrap|Theme And Bootstrap]]
- [[_COMMUNITY_PoopPal Branding|PoopPal Branding]]
- [[_COMMUNITY_Apple App Delegates|Apple App Delegates]]
- [[_COMMUNITY_Bristol UI|Bristol UI]]
- [[_COMMUNITY_Bottom Navigation|Bottom Navigation]]
- [[_COMMUNITY_Header UI|Header UI]]
- [[_COMMUNITY_Mood UI|Mood UI]]
- [[_COMMUNITY_Asset Catalog Metadata|Asset Catalog Metadata]]
- [[_COMMUNITY_macOS Generated Plugins|macOS Generated Plugins]]
- [[_COMMUNITY_Date Helpers|Date Helpers]]
- [[_COMMUNITY_Runner Tests|Runner Tests]]
- [[_COMMUNITY_Catalog Contents|Catalog Contents]]
- [[_COMMUNITY_Progress Cards|Progress Cards]]
- [[_COMMUNITY_Launch Images|Launch Images]]
- [[_COMMUNITY_LLDB Helper|LLDB Helper]]
- [[_COMMUNITY_Agent Hooks|Agent Hooks]]
- [[_COMMUNITY_Asset Constants|Asset Constants]]
- [[_COMMUNITY_Android Plugin Registrant|Android Plugin Registrant]]
- [[_COMMUNITY_iOS Plugin Registrant|iOS Plugin Registrant]]
- [[_COMMUNITY_Scene Delegate|Scene Delegate]]
- [[_COMMUNITY_PoopLog Model|PoopLog Model]]
- [[_COMMUNITY_Android Activity|Android Activity]]

## God Nodes (most connected - your core abstractions)
1. `pt Flutter Project` - 21 edges
2. `package:flutter/material.dart` - 15 edges
3. `_` - 12 edges
4. `iOS App Icon Family` - 10 edges
5. `AppDelegate` - 8 edges
6. `../../../shared/app_assets.dart` - 8 edges
7. `Linux Runner CMake Project` - 8 edges
8. `macOS AppIcon Asset Catalog Variants` - 8 edges
9. `iOS AppIcon Asset Catalog Variants` - 8 edges
10. `Bristol Stool Scale` - 8 edges

## Surprising Connections (you probably didn't know these)
- `macOS App Icon 1024px` --semantically_similar_to--> `iOS App Icon 1024pt 1x`  [INFERRED] [semantically similar]
  macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png → ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
- `macOS App Icon 512px` --semantically_similar_to--> `Web App Icon 512px`  [INFERRED] [semantically similar]
  macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png → web/icons/Icon-512.png
- `iOS App Icon Family` --semantically_similar_to--> `Android Launcher Icon Family`  [INFERRED] [semantically similar]
  ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png → android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
- `Graphify Query First Rule` --conceptually_related_to--> `pt Flutter Project`  [INFERRED]
  AGENTS.md → pubspec.yaml
- `iOS Launch Screen Assets` --conceptually_related_to--> `pt Flutter Project`  [INFERRED]
  ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md → pubspec.yaml

## Hyperedges (group relationships)
- **Flutter Project Package Configuration** — pubspec_pt_flutter_project, pubspec_dart_sdk_3_12, pubspec_flutter_sdk_dependency, pubspec_private_package_policy [EXTRACTED 1.00]
- **Drift SQLite Data Stack** — pubspec_drift_dependency, pubspec_sqlite3_flutter_libs_dependency, pubspec_drift_dev_dependency, pubspec_build_runner_dependency, devtools_options_drift_extension [INFERRED 0.85]
- **Flutter Static Analysis Stack** — analysis_options_dart_analyzer, analysis_options_flutter_lints, pubspec_flutter_lints_dependency [EXTRACTED 1.00]
- **Flutter Web Bootstrap Stack** — web_index_flutter_web_shell, web_index_base_href_placeholder, web_index_manifest, web_index_flutter_bootstrap [EXTRACTED 1.00]
- **Linux Desktop Build Stack** — linux_cmake_project_runner, linux_runner_cmake_executable, linux_flutter_cmake_flutter_library, linux_flutter_cmake_tool_backend, linux_cmake_gtk_dependency, linux_cmake_bundle_install [EXTRACTED 1.00]
- **Windows Desktop Build Stack** — windows_cmake_project_pt, windows_runner_cmake_executable, windows_flutter_cmake_flutter_library, windows_flutter_cmake_cpp_wrapper, windows_flutter_cmake_tool_backend, windows_cmake_install_runtime [EXTRACTED 1.00]
- **Cross Platform Flutter Scaffold** — pubspec_pt_flutter_project, web_index_flutter_web_shell, ios_launch_image_assets, linux_cmake_project_runner, windows_cmake_project_pt [INFERRED 0.80]
- **macOS App Icon Scaled Variants** — app_icon_16_macos_icon_16, app_icon_32_macos_icon_32, app_icon_64_macos_icon_64, app_icon_128_macos_icon_128, app_icon_256_macos_icon_256, app_icon_512_macos_icon_512, app_icon_1024_macos_icon_1024, asset_role_macos_app_iconset [EXTRACTED 1.00]
- **Web PWA Icon Variants** — favicon_web_favicon, icon_192_web_icon_192, icon_512_web_icon_512, icon_maskable_192_web_maskable_icon_192, icon_maskable_512_web_maskable_icon_512, asset_role_web_pwa_icons, asset_role_web_maskable_icons [EXTRACTED 1.00]
- **iOS Launch Image Scale Placeholders** — launchimage_ios_launch_image_1x, launchimage_ios_launch_image_2x, launchimage_ios_launch_image_3x, asset_role_ios_launch_placeholders [EXTRACTED 1.00]
- **iOS App Icon Scaled Variants** — icon_app_20x20_1x_ios_icon_20, icon_app_20x20_3x_ios_icon_60, icon_app_29x29_1x_ios_icon_29, icon_app_40x40_1x_ios_icon_40, icon_app_76x76_2x_ios_icon_152, icon_app_83_5x83_5_2x_ios_icon_167, icon_app_1024x1024_1x_ios_icon_1024, asset_role_ios_app_iconset [EXTRACTED 1.00]
- **Cross Platform Flutter Brand Assets** — asset_role_macos_app_iconset, asset_role_ios_app_iconset, asset_role_web_pwa_icons, asset_role_web_maskable_icons, asset_family_flutter_brand_icon, visual_motif_flutter_mark [INFERRED 0.90]
- **iOS Icon Density Variants** — icon_app_20x20_2x_ios_app_icon, icon_app_29x29_3x_ios_app_icon, icon_app_40x40_2x_ios_app_icon, icon_app_60x60_3x_ios_app_icon, icon_app_60x60_2x_ios_app_icon, icon_app_76x76_1x_ios_app_icon, icon_app_40x40_3x_ios_app_icon, icon_app_29x29_2x_ios_app_icon, ios_app_icon_family [EXTRACTED 1.00]
- **Android Launcher Density Variants** — ic_launcher_mdpi_android_launcher_icon, ic_launcher_hdpi_android_launcher_icon, ic_launcher_xhdpi_android_launcher_icon, ic_launcher_xxhdpi_android_launcher_icon, ic_launcher_xxxhdpi_android_launcher_icon, android_launcher_icon_family [EXTRACTED 1.00]
- **PoopPal Mascot Assets** — poop_mascot_pooppal_mascot_svg, toilet_paper_mascot_companion_svg, poop_pal_kawaii_mascot_png, pooppal_character_system [INFERRED 0.93]
- **PoopPal Feature Icon Set** — notes_sheet_notes_icon, insights_bars_analytics_icon, hydration_drop_hydration_icon, calendar_tab_calendar_icon, pooppal_tracking_feature_icons [EXTRACTED 0.95]
- **PoopPal Teal Accent Design Language** — poop_mascot_pooppal_mascot_svg, toilet_paper_mascot_companion_svg, notes_sheet_notes_icon, insights_bars_analytics_icon, hydration_drop_hydration_icon, calendar_tab_calendar_icon, pooppal_friendly_wellness_visual_language [INFERRED 0.88]
- **Mood Scale Assets** — mood_bad_bad_mood, mood_not_great_not_great_mood, mood_okay_okay_mood, mood_good_good_mood, mood_great_great_mood, ui_mood_scale [EXTRACTED 0.98]
- **Bristol Scale Assets** — bristol_type_1_bristol_stool_type_1, bristol_type_2_bristol_stool_type_2, bristol_type_3_bristol_stool_type_3, bristol_type_4_bristol_stool_type_4, bristol_type_5_bristol_stool_type_5, bristol_type_6_bristol_stool_type_6, bristol_type_7_bristol_stool_type_7, ui_bristol_stool_scale [EXTRACTED 0.99]
- **Health Metric Visuals** — poop_marker_poop_day_marker, fiber_leaf_fiber, streak_flame_streak_flame, ui_health_metrics, ui_progress_tracking [INFERRED 0.78]
- **Friendly Rounded Vector Language** — poop_marker_poop_day_marker, mood_great_great_mood, mood_good_good_mood, fiber_leaf_fiber, streak_flame_streak_flame, ui_friendly_digestive_design_language [INFERRED 0.74]

## Communities (53 total, 9 thin omitted)

### Community 0 - "Windows Runtime"
Cohesion: 0.10
Nodes (22): RegisterPlugins(), OnCreate(), Create(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetThisFromHandle(), GetWindowClass() (+14 more)

### Community 1 - "Calendar Persistence"
Cohesion: 0.08
Nodes (24): app_database.dart, calendar_day_button.dart, ../models/poop_log.dart, round_icon_button.dart, ../../../shared/date_helpers.dart, _logDateKey, _mapLog, PoopLogRepository (+16 more)

### Community 2 - "Project Tooling"
Cohesion: 0.09
Nodes (27): Graphify Query First Rule, Graphify Workflow Instructions, Dart Static Analyzer, Flutter Lints Analyzer Configuration, Drift DevTools Extension Enabled, iOS Launch Screen Assets, Build Runner Dependency, Cupertino Icons Dependency (+19 more)

### Community 3 - "Calendar Screen State"
Cohesion: 0.08
Nodes (25): ../data/poop_log_repository.dart, BristolSection, build, _clampSelectedDayToVisibleMonth, DateTime, _goToNextMonth, _goToPreviousMonth, initState (+17 more)

### Community 4 - "macOS App Icons"
Cohesion: 0.09
Nodes (25): macOS App Icon 1024px, macOS App Icon 128px, macOS App Icon 16px, macOS App Icon 256px, macOS App Icon 32px, macOS App Icon 512px, macOS App Icon 64px, Flutter Brand Icon Family (+17 more)

### Community 5 - "Health Tracking Assets"
Cohesion: 0.16
Nodes (20): Bristol Stool Type 1, Bristol Stool Type 2, Bristol Stool Type 3, Bristol Stool Type 4, Bristol Stool Type 5, Bristol Stool Type 6, Bristol Stool Type 7, Fiber (+12 more)

### Community 6 - "Linux Runtime"
Cohesion: 0.11
Nodes (7): fl_register_plugins(), main(), my_application_activate(), my_application_new(), _MyApplication, dart_entrypoint_arguments, parent_instance

### Community 7 - "Persistence Imports"
Cohesion: 0.12
Nodes (16): dart:io, package:drift/drift.dart, package:drift/native.dart, package:flutter_test/flutter_test.dart, package:path/path.dart, package:path_provider/path_provider.dart, package:pt/app/poop_tracker_app.dart, package:pt/features/calendar/data/app_database.dart (+8 more)

### Community 8 - "Launcher Icons"
Cohesion: 0.13
Nodes (16): Android Launcher Icon Family, Flutter Default Brand Mark, Android Launcher Icon hdpi, Android Launcher Icon mdpi, Android Launcher Icon xhdpi, Android Launcher Icon xxhdpi, Android Launcher Icon xxxhdpi, iOS App Icon 20pt @2x (+8 more)

### Community 9 - "Windows Windowing"
Cohesion: 0.21
Nodes (5): FlutterWindow(), wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 10 - "Windows Build"
Cohesion: 0.18
Nodes (13): Windows pt Executable Target, Windows Flutter Managed Directory, Windows Runtime Install Layout, Windows pt CMake Project, Windows Standard CMake Settings, Windows Unicode Definitions, Windows Flutter C++ Wrapper Libraries, Windows Flutter Ephemeral Configuration (+5 more)

### Community 11 - "Linux Build"
Cohesion: 0.23
Nodes (12): Linux GTK Application ID, Linux pt Executable Target, Linux Relocatable Bundle Install, Linux Flutter Managed Directory, Linux GTK Dependency, Linux Runner CMake Project, Linux Standard CMake Settings, Linux Flutter Ephemeral Configuration (+4 more)

### Community 12 - "App Root Injection"
Cohesion: 0.18
Nodes (10): ../features/calendar/data/app_database.dart, ../features/calendar/data/poop_log_repository.dart, ../features/calendar/screens/poop_calendar_screen.dart, theme.dart, build, dispose, initState, MaterialApp (+2 more)

### Community 13 - "Drift Generated Model"
Cohesion: 0.20
Nodes (11): _, copyWith, copyWithCompanion, Function, map, PoopLog, PoopLogsCompanion, RawValuesInsertable (+3 more)

### Community 14 - "SVG UI Widgets"
Cohesion: 0.20
Nodes (9): package:flutter_svg/flutter_svg.dart, ../../../shared/app_assets.dart, build, CalendarDayButton, DecoratedBox, SizedBox, build, Card (+1 more)

### Community 15 - "Web Manifest"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 16 - "Theme And Bootstrap"
Cohesion: 0.20
Nodes (7): app/poop_tracker_app.dart, package:flutter/material.dart, AppTheme, ThemeData, build, RoundIconButton, main

### Community 17 - "PoopPal Branding"
Cohesion: 0.40
Nodes (10): Calendar Tab Icon, Hydration Drop Icon, Insights Bars Icon, Notes Sheet Icon, PoopPal Poop Mascot SVG, PoopPal Kawaii Mascot PNG, PoopPal Character System, PoopPal Friendly Wellness Visual Language (+2 more)

### Community 18 - "Apple App Delegates"
Cohesion: 0.22
Nodes (3): FlutterAppDelegate, FlutterImplicitEngineDelegate, AppDelegate

### Community 19 - "Bristol UI"
Cohesion: 0.25
Nodes (7): BristolSection, BristolTypeButton, build, Card, Container, Icon, SizedBox

### Community 20 - "Bottom Navigation"
Cohesion: 0.25
Nodes (7): build, CenterLogButton, NavItem, Padding, PoopBottomNavigation, Semantics, SizedBox

### Community 21 - "Header UI"
Cohesion: 0.29
Nodes (6): AppHeader, build, getClip, HeaderClipper, shouldReclip, SizedBox

### Community 22 - "Mood UI"
Cohesion: 0.29
Nodes (6): build, Card, Column, MoodButton, MoodSection, SizedBox

### Community 23 - "Asset Catalog Metadata"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 24 - "macOS Generated Plugins"
Cohesion: 0.33
Nodes (3): RegisterGeneratedPlugins(), NSWindow, MainFlutterWindow

### Community 25 - "Date Helpers"
Cohesion: 0.33
Nodes (5): dateOnly, isSameDay, monthTitle, shortMonthTitle, weekdayShort

### Community 27 - "Catalog Contents"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 28 - "Progress Cards"
Cohesion: 0.40
Nodes (4): build, Card, ProgressCard, SizedBox

### Community 29 - "Launch Images"
Cohesion: 0.83
Nodes (4): iOS Launch Image Placeholder Variants, iOS Launch Image 1x Placeholder, iOS Launch Image 2x Placeholder, iOS Launch Image 3x Placeholder

## Knowledge Gaps
- **205 isolated node(s):** `version`, `author`, `main`, `package:pt/features/calendar/models/poop_log.dart`, `main` (+200 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `package:flutter/material.dart` connect `Theme And Bootstrap` to `Calendar Persistence`, `Calendar Screen State`, `Persistence Imports`, `App Root Injection`, `SVG UI Widgets`, `Bristol UI`, `Bottom Navigation`, `Header UI`, `Mood UI`, `Progress Cards`?**
  _High betweenness centrality (0.065) - this node is a cross-community bridge._
- **Why does `pt Flutter Project` connect `Project Tooling` to `Windows Build`, `Linux Build`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **Why does `../../../shared/app_assets.dart` connect `SVG UI Widgets` to `Calendar Persistence`, `Calendar Screen State`, `Bristol UI`, `Bottom Navigation`, `Header UI`, `Mood UI`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **Are the 5 inferred relationships involving `pt Flutter Project` (e.g. with `Graphify Query First Rule` and `Flutter Web HTML Shell`) actually correct?**
  _`pt Flutter Project` has 5 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `iOS App Icon Family` (e.g. with `Flutter Default Brand Mark` and `Android Launcher Icon Family`) actually correct?**
  _`iOS App Icon Family` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `version`, `author`, `main` to the rest of the system?**
  _209 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runtime` be split into smaller, more focused modules?**
  _Cohesion score 0.1032258064516129 - nodes in this community are weakly interconnected._