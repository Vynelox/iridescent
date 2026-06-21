# Implementation Plan: Juice Cut Video Editor — React/TypeScript to QML/C++ Translation

[Overview]
Translate the entire Juice Cut video editor from React/TypeScript to QML/C++, implementing all UI behavior in QML and all logic/computation in C++. The plan is organized into sequential feature blocks: (1) Build System & Styling Foundation, (2) Core Data Models & State Management, (3) Core UI — MediaPool + Viewer + Timeline + Basic Playback, (4) Timeline Editing Features, (5) Settings System, (6) Styles/Themes System, (7) Color Picker, (8) Torus Menu, (9) Keyboard Shortcuts & Undo/Redo, (10) Export. Each block builds on the previous ones.

[Types]
**C++ Data Types (to be registered with QMetaType):**
- `MediaItem`: id(QString), name(QString), type(MediaType enum: Video/Audio/Image), src(QString), duration(int frames), width(int), height(int), thumbnail(QString)
- `TimelineClip`: id(QString), mediaId(QString), track(int), startFrame(int), endFrame(int), srcIn(int), srcOut(int), fades(Fade struct), name(QString), type(MediaType)
- `Fade`: in(int frames), out(int frames)
- `Track`: id(QString), type(TrackType enum: Video/Audio), label(QString)
- `AppSnapshot`: clips(QVariantList), mediaItems(QVariantMap), selectedIds(QStringList), playhead(int), settings(QVariantMap), layout(QVariantMap)
- `PlayneedleParams`: t(double), j(double), k(double), s(double), v_o(double), h_b(double), h_r(double)
- `ColorVarName`: enum of all 16 CSS variable names
- `ThemeColors`: QMap<QString, QString> mapping ColorVarName to hex color
- `ShortcutAction`: enum (undo, redo, timelineZoomToggle, exitModal)

**QML Types:**
- All QML components mirror the React component hierarchy
- C++ classes exposed as QML singletons or context properties
- Styling system uses QML property bindings to a Theme singleton

[Files]

**New C++ Header Files (src/cpp/):**
- `src/cpp/MediaItem.h` — MediaItem data class
- `src/cpp/TimelineClip.h` — TimelineClip + Fade data classes
- `src/cpp/Track.h` — Track data class
- `src/cpp/MediaModel.h` — QAbstractListModel for media items
- `src/cpp/ClipModel.h` — QAbstractListModel for timeline clips
- `src/cpp/HistoryManager.h` — Undo/redo stack management
- `src/cpp/SettingsManager.h` — QSettings wrapper for all app settings
- `src/cpp/ThemeManager.h` — Theme/color management, CSS variable generation
- `src/cpp/ShortcutManager.h` — Keyboard shortcut loading, saving, matching
- `src/cpp/PlayneedleEngine.h` — Formula evaluation f(x) for playneedle shape
- `src/cpp/ColorEngine.h` — HSL/RGB/Hex conversion utilities
- `src/cpp/WaveformEngine.h` — Audio peak computation (offline audio context equivalent)
- `src/cpp/ThumbnailEngine.h` — Video frame capture for thumbnails
- `src/cpp/ExportEngine.h` — Video export via QMediaRecorder or FFmpeg
- `src/cpp/AppState.h` — Central application state (playhead, playing, selectedIds, zoom)
- `src/cpp/Types.h` — Common enums and type definitions

**New C++ Source Files (src/cpp/):**
- Corresponding .cpp files for each header above
- `src/cpp/main.cpp` — Updated bootstrap registering all C++ types with QML

**New QML Files (src/components/):**
- `src/components/Styles.qml` — CSS-like styling system (replaces Tailwind + CSS variables)
- `src/components/ColorPicker.qml` — Full color picker with wheel, hex input, lightness slider
- `src/components/Settings.qml` — Settings modal with tabs (Keyboard, Sliders, Checkboxes, Multiselects, Components)
- `src/components/StylesModal.qml` — Theme browser/editor modal
- `src/components/TorusMenu.qml` — Radial context menu
- `src/components/TorusMenuEditor.qml` — Torus menu settings editor
- `src/components/DraggableModal.qml` — Draggable modal wrapper
- `src/components/Splitter.qml` — Draggable splitter (vertical/horizontal)
- `src/components/Waveform.qml` — Audio waveform visualization
- `src/components/ThumbnailRoll.qml` — Video thumbnail strip
- `src/components/RollDialog.qml` — Source roll edit dialog
- `src/components/FormulaPlayneedle.qml` — SVG-based formula playneedle
- `src/components/Adjustables.qml` — Slider, Checkbox, Multiselect, Keybind reusable components
- `src/components/KeybindChip.qml` — Keybind editing chip component

**Modified Files:**
- `src/CMakeLists.txt` — Add C++ files, Qt Multimedia, Qt Quick Controls dependencies
- `src/main.cpp` — Register all C++ types, set up QML engine with context properties
- `src/Editor.qml` — Complete rewrite: app shell with header, workspace grid, splitters
- `src/components/MediaPool.qml` — Complete rewrite with media list, drag support, file import
- `src/components/Viewer.qml` — Complete rewrite with canvas rendering, transport controls
- `src/components/Timeline.qml` — Complete rewrite with ruler, tracks, clips, playhead, zoom, scroll
- `src/resources.qrc` — Add all new files to Qt resource system

[Functions]

**C++ Functions (registered as Q_INVOKABLE or in Q_PROPERTY):**

*AppState (singleton):*
- `playhead() / setPlayhead(int)` — Current frame position
- `playing() / setPlaying(bool)` — Playback state
- `selectedIds() / setSelectedIds(QStringList)` — Selected clip IDs
- `zoom() / setZoom(double)` — Timeline zoom level
- `totalFrames()` — Computed from clips
- `formatTimecode(int frames) -> QString` — "HH:MM:SS:FF" formatting
- `framesToSeconds(int) -> double`
- `secondsToFrames(double) -> int`
- `generateId() -> QString` — Random ID generation

*MediaModel:*
- `addMediaItem(MediaItem)` — Add media from file
- `removeMediaId(QString id)` — Remove media and associated clips
- `getMedia(QString id) -> MediaItem` — Lookup by ID
- `mediaCount() -> int`
- `mediaAt(int index) -> MediaItem`

*ClipModel:*
- `addClip(TimelineClip)` — Add clip to timeline
- `removeClip(QString id)`
- `updateClip(QString id, TimelineClip updated)`
- `clipsForTrack(int track) -> QList<TimelineClip>`
- `clipAt(QString id) -> TimelineClip`
- `splitClip(QString clipId, int frame)` — Split into two clips
- `trimClip(QString clipId, int frame, bool latter, bool ripple)`
- `nudgeClips(QStringList ids, int deltaFrames)`
- `joinClips(QString clipAId, QString clipBId)`
- `fadeChange(QString clipId, QString side, int frames)`
- `rollClip(QString clipId, int newSrcIn, int newSrcOut)`
- `stepEdge(QString clipId, QStringList cutBetween, int direction, bool ripple)`

*HistoryManager:*
- `Q_INVOKABLE void push(AppSnapshot snapshot)`
- `Q_INVOKABLE void undo(AppSnapshot current, std::function<void(AppSnapshot)> restore)`
- `Q_INVOKABLE void redo(AppSnapshot current, std::function<void(AppSnapshot)> restore)`
- `Q_INVOKABLE void clear()`
- `canUndo() -> bool`
- `canRedo() -> bool`
- `Q_SIGNAL void canUndoChanged()`
- `Q_SIGNAL void canRedoChanged()`

*SettingsManager (singleton, wraps QSettings):*
- All settings as Q_PROPERTY with READ/WRITE/NOTIFY
- `guiScale`, `includeResizeInUndo`, `zoomEpicenter`, `scrollSmooth`, `scrollAmount`, `scrollZoomAmount`, `scrollZoomSmoothness`, `viewerControlsType`, `timecodePanel`, `elevatedPanelDarken`, `elevatedPanelBlur`, playneedle params (pnT, pnJ, pnK, pnS, pnVo, pnHb, pnHr), torus settings (animType, bounce, speed, smoothness)
- `Q_INVOKABLE void resetAll()`
- `Q_SIGNAL void settingChanged(QString key, QVariant value)` — Mirrors React's CustomEvent

*ThemeManager (singleton):*
- `Q_PROPERTY ThemeColors activeTheme READ activeTheme WRITE setActiveTheme NOTIFY themeChanged)`
- `Q_PROPERTY QString activeThemeName READ activeThemeName NOTIFY themeChanged)`
- `Q_INVOKABLE void applyTheme(QString themeName)`
- `Q_INVOKABLE ThemeColors getThemeColors(QString themeName)`
- `Q_INVOKABLE void updateColor(ColorVarName varName, QString hex)`
- `Q_INVOKABLE void resetColor(ColorVarName varName)`
- `Q_INVOKABLE QStringList availableThemes()`
- `Q_INVOKABLE QStringList availableFolders()`
- `Q_INVOKABLE QString getParentId(QString itemId)`
- `Q_SIGNAL void themeChanged()`

*ShortcutManager (singleton):*
- `Q_PROPERTY Record<ShortcutAction, QList<QStringList>> shortcuts READ shortcuts NOTIFY shortcutsChanged)`
- `Q_INVOKABLE bool isMatch(ShortcutAction action, int key, bool ctrl, bool shift, bool alt)`
- `Q_INVOKABLE void updateShortcuts(Record<ShortcutAction, QList<QStringList>>)`
- `Q_INVOKABLE void resetDefault(ShortcutAction action)`
- `Q_INVOKABLE void resetAll()`
- `Q_SIGNAL void shortcutsChanged()`

*PlayneedleEngine:*
- `static double evaluateF(double x, PlayneedleParams params)` — The formula f(x)
- `static QString generateSvgPath(int height, int maxWidth, PlayneedleParams params)`

*ColorEngine:*
- `static QColor hexToRgb(QString hex)`
- `static QString rgbToHex(int r, int g, int b)`
- `static QColor hslToRgb(double h, double s, double l)`
- `static QVector<double> rgbToHsl(int r, int g, int b)`
- `static QString hslToHex(double h, double s, double l)`
- `static QVector<double> hexToHsl(QString hex)`

*WaveformEngine (QObject, async):*
- `Q_INVOKABLE void computePeaks(QString src, int samples)`
- `Q_SIGNAL void peaksReady(QString src, QVector<float> peaks)`

*ThumbnailEngine (QObject, async):*
- `Q_INVOKABLE void captureFrames(QString src, int count, int width, int height)`
- `Q_SIGNAL void framesReady(QString src, QStringList base64Images)`

*ExportEngine (QObject, async):*
- `Q_INVOKABLE void startExport(QString path, bool video, bool audio)`
- `Q_SIGNAL void exportProgress(double percent)`
- `Q_SIGNAL void exportFinished(bool success, QString error)`

[Classes]

**C++ Classes:**

1. **`AppState : public QObject`** — Central application state singleton
   - Properties: playhead, playing, selectedIds, zoom, totalFrames
   - Signals: playheadChanged, playingChanged, selectedIdsChanged, zoomChanged
   - Slots: play(), pause(), togglePlay(), seek(int frame), selectClip(QString id, bool multi)

2. **`MediaModel : public QAbstractListModel`** — List model for media items
   - Roles: IdRole, NameRole, TypeRole, SrcRole, DurationRole, ThumbnailRole
   - Methods: addMedia, removeMedia, getMedia, clear

3. **`ClipModel : public QAbstractListModel`** — List model for timeline clips
   - Roles: IdRole, MediaIdRole, TrackRole, StartFrameRole, EndFrameRole, SrcInRole, SrcOutRole, FadesRole, NameRole, TypeRole
   - Methods: addClip, removeClip, updateClip, splitClip, trimClip, nudgeClips, joinClips, fadeChange, rollClip, stepEdge, clipsForTrack

4. **`HistoryManager : public QObject`** — Undo/redo stack
   - Properties: canUndo, canRedo
   - Methods: push, undo, redo, clear
   - Internal: QList<AppSnapshot> undoStack, redoStack, max 200 entries

5. **`SettingsManager : public QObject`** — Persistent settings via QSettings
   - All settings as Q_PROPERTY
   - Organization: "JuiceCut", Application: "Iridescent"
   - Signal: settingChanged(QString key, QVariant value)

6. **`ThemeManager : public QObject`** — Theme/color management
   - Properties: activeTheme (ThemeColors), activeThemeName (QString)
   - Internal: QMap<QString, ThemeColors> built-in themes (og-dark, og-light, monokai, lavender, cyberpunk, oak, forest)
   - Folder/theme hierarchy: Vynelox built-in > plain > 7 themes
   - Methods: applyTheme, getThemeColors, updateColor, resetColor

7. **`ShortcutManager : public QObject`** — Keyboard shortcut management
   - Properties: shortcuts (QVariantMap)
   - Methods: isMatch, updateShortcuts, resetDefault, resetAll
   - Default shortcuts: undo=Ctrl+Z, redo=Ctrl+Shift+Z/Ctrl+Y/Ctrl+Alt+Z, timelineZoomToggle=Alt, exitModal=Escape

8. **`PlayneedleEngine`** — Static utility class
   - evaluateF(double x, PlayneedleParams) — Formula evaluation
   - generateSvgPath(int height, int maxWidth, PlayneedleParams) — SVG path generation

9. **`ColorEngine`** — Static utility class for color conversions

10. **`WaveformEngine : public QObject`** — Async audio peak computation
    - Uses QAudioDecoder or manual audio decoding
    - Signal: peaksReady when computation completes

11. **`ThumbnailEngine : public QObject`** — Async video frame capture
    - Uses QMediaPlayer + QVideoSink for frame grabbing
    - Signal: framesReady when thumbnails captured

12. **`ExportEngine : public QObject`** — Video export
    - Uses QMediaRecorder or FFmpeg integration
    - Signals: exportProgress, exportFinished

[Dependencies]
**New Qt Modules Required (add to CMakeLists.txt):**
- `Qt6::Multimedia` — Video playback, audio decoding, video frame capture
- `Qt6::MultimediaWidgets` — Video widget rendering
- `Qt6::QuickControls2` — Additional QML controls
- `Qt6::Svg` — SVG rendering for playneedle and icons

**CMakeLists.txt Changes:**
```
find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 Multimedia MultimediaWidgets Svg)
```
- Add all .cpp/.h files to the executable target
- Add QML files to qt_add_qml_module
- Set C++ standard to C++17 minimum

**No External Dependencies Beyond Qt 6.11.1:**
- All functionality implemented using Qt built-in classes
- No FFmpeg dependency (use Qt Multimedia for playback/export)
- No additional npm/pip packages needed

[Testing]
**Testing Strategy:**
1. **Build verification**: Ensure CMake configures and builds without errors after each feature block
2. **QML runtime verification**: Launch the application and verify each component renders correctly
3. **C++ unit tests** (optional, using Qt Test): Test data model operations (split, trim, nudge, join), color conversions, playneedle formula evaluation, timecode formatting
4. **Integration testing**: Verify signal/slot connections between C++ and QML work correctly
5. **Manual feature testing**: For each feature block, verify the UI behavior matches the React original

**Test Files (if Qt Test is added):**
- `tests/test_models.cpp` — MediaModel, ClipModel operations
- `tests/test_color.cpp` — ColorEngine conversions
- `tests/test_playneedle.cpp` — PlayneedleEngine formula
- `tests/test_timecode.cpp` — Timecode formatting
- `tests/test_shortcuts.cpp` — Shortcut matching

[Implementation Order]

**Phase 0: Build System & Project Setup**
- [ ] 0.1: Update CMakeLists.txt with new Qt modules (Multimedia, QuickControls2, Svg)
- [ ] 0.2: Create src/cpp/ directory structure
- [ ] 0.3: Update main.cpp to register C++ types with QML engine
- [ ] 0.4: Update resources.qrc to include all new files
- [ ] 0.5: Verify build succeeds with empty stubs

**Phase 1: Styling System**
- [ ] 1.1: Create ThemeManager C++ class with all built-in themes
- [ ] 1.2: Create Styles.qml — QML styling system with all CSS variables as properties
- [ ] 1.3: Implement GUI scale support (font sizes, spacing, icon sizes)
- [ ] 1.4: Implement dark/light theme switching
- [ ] 1.5: Verify styling renders correctly on existing UI

**Phase 2: Core Data Models & State**
- [ ] 2.1: Create Types.h with all enums (MediaType, TrackType, etc.)
- [ ] 2.2: Create MediaItem.h data class
- [ ] 2.3: Create TimelineClip.h + Fade data classes
- [ ] 2.4: Create Track.h data class
- [ ] 2.5: Create MediaModel C++ class (QAbstractListModel)
- [ ] 2.6: Create ClipModel C++ class (QAbstractListModel)
- [ ] 2.7: Create AppState C++ singleton with playhead, playing, selectedIds, zoom
- [ ] 2.8: Create SettingsManager C++ singleton
- [ ] 2.9: Create ColorEngine static utility class
- [ ] 2.10: Create PlayneedleEngine static utility class
- [ ] 2.11: Wire all C++ classes into main.cpp QML registration
- [ ] 2.12: Verify data models work from QML

**Phase 3: Core UI — MediaPool + Viewer + Timeline + Basic Playback**
- [ ] 3.1: Rewrite Editor.qml — full app shell with header, workspace grid, splitters
- [ ] 3.2: Rewrite MediaPool.qml — media list, file import, drag support, thumbnails
- [ ] 3.3: Rewrite Viewer.qml — canvas rendering, transport controls, timecode display
- [ ] 3.4: Rewrite Timeline.qml — ruler, tracks, clips, playhead, zoom, scroll
- [ ] 3.5: Create FormulaPlayneedle.qml — SVG-based playneedle using PlayneedleEngine
- [ ] 3.6: Create Splitter.qml — draggable splitter component
- [ ] 3.7: Implement basic playback (play/pause, playhead advancement)
- [ ] 3.8: Implement clip rendering on timeline (colored blocks with labels)
- [ ] 3.9: Implement playhead dragging and seeking
- [ ] 3.10: Implement timeline zoom (+/- buttons)
- [ ] 3.11: Implement horizontal scrolling with mouse wheel
- [ ] 3.12: Verify core editing workflow: import media → drag to timeline → play

**Phase 4: Timeline Editing Features**
- [ ] 4.1: Implement clip selection (click, multi-select with shift)
- [ ] 4.2: Implement clip dragging on timeline
- [ ] 4.3: Implement clip splitting (split at playhead position)
- [ ] 4.4: Implement clip trimming (ripple and non-ripple)
- [ ] 4.5: Implement clip nudging (arrow keys)
- [ ] 4.6: Implement clip joining (merge adjacent same-media clips)
- [ ] 4.7: Implement fade handles (in/out fade overlays)
- [ ] 4.8: Implement roll edit (source in/out adjustment)
- [ ] 4.9: Implement step edge (nudge clip edges)
- [ ] 4.10: Create RollDialog.qml — source roll edit modal
- [ ] 4.11: Implement join buttons between adjacent clips
- [ ] 4.12: Verify all editing operations work correctly

**Phase 5: Settings System**
- [ ] 5.1: Create SettingsManager C++ class with all settings properties
- [ ] 5.2: Create Adjustables.qml — Slider, Checkbox, Multiselect, Keybind components
- [ ] 5.3: Create Settings.qml — full settings modal with tabs
- [ ] 5.4: Implement Keyboard shortcuts tab (keybind editing)
- [ ] 5.5: Implement Sliders tab (GUI scale, scroll, playneedle params)
- [ ] 5.6: Implement Checkboxes tab (include resize in undo)
- [ ] 5.7: Implement Multiselects tab (viewer controls, timecode display, zoom epicenter)
- [ ] 5.8: Implement Components tab (torus menu editor link)
- [ ] 5.9: Implement settings persistence (QSettings)
- [ ] 5.10: Implement settings change signals (mirrors React's CustomEvent)
- [ ] 5.11: Verify all settings persist and affect the UI

**Phase 6: Styles/Themes System**
- [ ] 6.1: Create ThemeManager C++ class with built-in themes
- [ ] 6.2: Create StylesModal.qml — theme browser with folder hierarchy
- [ ] 6.3: Implement theme grid view (icons, labels, active indicator)
- [ ] 6.4: Implement folder navigation (drill down, back button)
- [ ] 6.5: Implement color editing view (color swatches, reset buttons)
- [ ] 6.6: Wire color changes to live CSS variable updates
- [ ] 6.7: Verify theme switching works in real-time

**Phase 7: Color Picker**
- [ ] 7.1: Create ColorPicker.qml — full color picker component
- [ ] 7.2: Implement hue/saturation wheel (Canvas-based, pixel-by-pixel rendering)
- [ ] 7.3: Implement selection indicator (draggable circle on wheel)
- [ ] 7.4: Implement lightness slider
- [ ] 7.5: Implement hex input field with validation
- [ ] 7.6: Implement color preview swatch
- [ ] 7.7: Implement undo/revert button (previous color)
- [ ] 7.8: Implement popover positioning (auto-fit to viewport)
- [ ] 7.9: Implement fullscreen mode (portal equivalent)
- [ ] 7.10: Implement drag-to-move for popover
- [ ] 7.11: Verify color picker integrates with StylesModal

**Phase 8: Torus Menu**
- [ ] 8.1: Create TorusMenu.qml — radial context menu
- [ ] 8.2: Implement annular sector SVG paths
- [ ] 8.3: Implement sector click handling
- [ ] 8.4: Implement animation types (none, pop, clock)
- [ ] 8.5: Implement bounce and smoothness parameters
- [ ] 8.6: Implement inside menu items (Split, Trim, Ripple, Roll)
- [ ] 8.7: Implement edge menu items (Step, Ripple Step)
- [ ] 8.8: Implement close button
- [ ] 8.9: Implement scroll-to-close and background-click-to-close
- [ ] 8.10: Create TorusMenuEditor.qml — preview and settings
- [ ] 8.11: Verify torus menu appears on playhead click

**Phase 9: Keyboard Shortcuts & Undo/Redo**
- [ ] 9.1: Create ShortcutManager C++ class
- [ ] 9.2: Create HistoryManager C++ class
- [ ] 9.3: Implement keyboard event filtering in QML (KeyEvent handler)
- [ ] 9.4: Implement undo/redo key bindings (Ctrl+Z, Ctrl+Shift+Z, Ctrl+Y)
- [ ] 9.5: Implement snapshot/restore for all editing operations
- [ ] 9.6: Implement resize-in-undo toggle
- [ ] 9.7: Implement Alt+D (deselect all)
- [ ] 9.8: Implement Space (play/pause toggle)
- [ ] 9.9: Implement Escape (close modals via close stack)
- [ ] 9.10: Implement wheel shortcut matching (timeline zoom toggle with Alt)
- [ ] 9.11: Verify all shortcuts work correctly

**Phase 10: Export**
- [ ] 10.1: Create ExportEngine C++ class
- [ ] 10.2: Implement video frame rendering to canvas
- [ ] 10.3: Implement MediaRecorder integration
- [ ] 10.4: Create export dialog (DraggableModal with options)
- [ ] 10.5: Implement export progress tracking
- [ ] 10.6: Implement file save dialog
- [ ] 10.7: Verify export produces playable video file

**Phase 11: Advanced Features & Polish**
- [ ] 11.1: Create WaveformEngine C++ class for audio peak computation
- [ ] 11.2: Create Waveform.qml — audio waveform visualization
- [ ] 11.3: Create ThumbnailEngine C++ class for video frame capture
- [ ] 11.4: Create ThumbnailRoll.qml — video thumbnail strip
- [ ] 11.5: Implement media duration detection on import
- [ ] 11.6: Implement thumbnail generation on import
- [ ] 11.7: Implement drag-and-drop from file system
- [ ] 11.8: Implement clip fade rendering (gradient overlays)
- [ ] 11.9: Implement timecode display in viewer
- [ ] 11.10: Final polish: scrollbars, hover states, transitions, cursor shapes