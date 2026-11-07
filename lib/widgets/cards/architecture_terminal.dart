import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import 'glass_card.dart';

class ArchitectureTerminal extends StatefulWidget {
  const ArchitectureTerminal({super.key});

  @override
  State<ArchitectureTerminal> createState() => _ArchitectureTerminalState();
}

class _ArchitectureTerminalState extends State<ArchitectureTerminal> {
  int _activeTab = 0;
  bool _copied = false;

  final List<_CodeSnippet> _snippets = [
    const _CodeSnippet(
      filename: 'sensor_telemetry_bloc.dart',
      language: 'Dart (Clean BLoC)',
      code: '''
class SensorTelemetryBloc extends Bloc<SensorEvent, SensorState> {
  final MqttTelemetryRepository _repository;
  StreamSubscription<SensorReading>? _streamSub;

  SensorTelemetryBloc(this._repository) : super(SensorInitial()) {
    on<SubscribeToEdgeNodes>(_onSubscribe);
    on<TelemetryReceived>(_onTelemetryReceived);
  }

  Future<void> _onSubscribe(
    SubscribeToEdgeNodes event,
    Emitter<SensorState> emit,
  ) async {
    emit(SensorConnecting());
    await _streamSub?.cancel();
    _streamSub = _repository.streamSensorNodes(event.nodeIds).listen(
      (reading) => add(TelemetryReceived(reading)),
      onError: (err) => emit(SensorError(err.toString())),
    );
  }
}''',
    ),
    const _CodeSnippet(
      filename: 'clean_domain_usecase.dart',
      language: 'Domain Layer',
      code: '''
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class DispatchEmergencyActuator 
    implements UseCase<ActuatorResult, ActuatorParams> {
  final IIoTDeviceRepository repository;

  DispatchEmergencyActuator(this.repository);

  @override
  Future<Either<Failure, ActuatorResult>> call(
    ActuatorParams params,
  ) async {
    // Edge validation and low-latency MQTT command dispatch
    return await repository.triggerValve(
      valveId: params.valveId,
      pressureKPa: params.targetPressure,
    );
  }
}''',
    ),
    const _CodeSnippet(
      filename: 'clean_island_theme.dart',
      language: 'Design System',
      code: '''
class CleanIslandTokens {
  static const Color pureCanvas = Color(0xFFF8FAFC);
  static const Color skyAccent = Color(0xFF0284C7);
  static const Color oceanDeep = Color(0xFF2563EB);
  static const Color textCharcoal = Color(0xFF0F172A);

  static BoxDecoration glassSurface({double blur = 16.0}) => BoxDecoration(
    color: Colors.white.withValues(alpha: 0.85),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.white.withValues(alpha: 0.8),
      width: 1.2,
    ),
    boxShadow: [
      BoxShadow(
        color: textCharcoal.withValues(alpha: 0.04),
        blurRadius: blur,
        offset: const Offset(0, 8),
      ),
    ],
  );
}''',
    ),
  ];

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _snippets[_activeTab].code));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final snippet = _snippets[_activeTab];
    final lines = snippet.code.trim().split('\n');

    return GlassCard(
      borderRadius: 24,
      blur: 20,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.white.withValues(alpha: 0.94),
      borderColor: const Color(0xFFE2E8F0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Window Chrome Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // macOS window dots & file tabs
                Expanded(
                  child: Row(
                    children: [
                      _buildDot(const Color(0xFFEF4444)),
                      const SizedBox(width: 6),
                      _buildDot(const Color(0xFFF59E0B)),
                      const SizedBox(width: 6),
                      _buildDot(const Color(0xFF10B981)),
                      const SizedBox(width: 14),
                      // File tabs
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(_snippets.length, (index) {
                              final isSelected = _activeTab == index;
                              return Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => setState(() => _activeTab = index),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: isSelected
                                            ? Border.all(
                                                color: const Color(0xFFCBD5E1),
                                                width: 1.0,
                                              )
                                            : null,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.code_rounded,
                                            size: 13,
                                            color: isSelected
                                                ? AppColors.primary
                                                : AppColors.textMuted,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            _snippets[index].filename,
                                            style: AppTypography.code.copyWith(
                                              fontSize: 11.5,
                                              color: isSelected
                                                  ? AppColors.textPrimary
                                                  : AppColors.textMuted,
                                              fontWeight: isSelected
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Copy to clipboard action
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _copyCode,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _copied
                                ? Icons.check_circle_rounded
                                : Icons.copy_rounded,
                            size: 12,
                            color: _copied
                                ? AppColors.onlineGreen
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _copied ? 'Copied' : 'Copy',
                            style: AppTypography.code.copyWith(
                              fontSize: 10.5,
                              color: _copied
                                  ? AppColors.onlineGreen
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Code Body with Line Numbers
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Line Numbers
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(lines.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '${i + 1}',
                          style: AppTypography.code.copyWith(
                            color: const Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 18),
                  Container(
                    width: 1,
                    height: lines.length * 19.0,
                    color: const Color(0xFFE2E8F0),
                  ),
                  const SizedBox(width: 18),

                  // Code text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: lines.map((line) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: _buildHighlightedLine(line),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildHighlightedLine(String line) {
    // Clean minimal syntax highlighting
    final isComment = line.trim().startsWith('//');
    if (isComment) {
      return Text(
        line,
        style: AppTypography.code.copyWith(
          color: const Color(0xFF94A3B8),
          fontStyle: FontStyle.italic,
          fontSize: 12,
        ),
      );
    }

    final isKeyword = line.contains('class ') ||
        line.contains('implements ') ||
        line.contains('extends ') ||
        line.contains('async ') ||
        line.contains('await ') ||
        line.contains('return ') ||
        line.contains('final ') ||
        line.contains('static ') ||
        line.contains('const ');

    return Text(
      line,
      style: AppTypography.code.copyWith(
        color: isKeyword ? const Color(0xFF0284C7) : const Color(0xFF0F172A),
        fontWeight: isKeyword ? FontWeight.w600 : FontWeight.w400,
        fontSize: 12,
      ),
    );
  }
}

class _CodeSnippet {
  final String filename;
  final String language;
  final String code;

  const _CodeSnippet({
    required this.filename,
    required this.language,
    required this.code,
  });
}
