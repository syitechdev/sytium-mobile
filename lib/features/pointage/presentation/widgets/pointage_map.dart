import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sytium_mobile/core/config/app_config.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/radar_sweep_overlay.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Exigé par la politique d'usage des tuiles OSM : chaque requête doit
/// s'identifier. Doit correspondre à l'identifiant applicatif réel.
const _kUserAgent = 'tech.sytium.mobile';

const _kDefaultZoom = 17.0;

/// Cadre de repli tant qu'aucune position n'est connue : centre d'Abidjan.
const _kFallbackCenter = LatLng(5.3599, -4.0083);

/// Carte du pointage : tuiles OSM, zones autorisées de l'organisation, position
/// de l'employé, et le balayage radar pendant la recherche.
///
/// Purement présentationnelle — elle ne décide de rien. Le verdict de zone
/// appartient au serveur ; le cercle affiché n'est qu'une aide à la lecture.
class PointageMap extends StatelessWidget {
  const PointageMap({
    required this.position,
    required this.sites,
    required this.scanning,
    required this.scanTrigger,
    super.key,
  });

  /// Position de l'employé, nulle tant qu'elle n'est pas acquise.
  final LatLng? position;

  /// Zones actives de l'organisation, telles que renvoyées par l'API.
  final List<PointageZone> sites;

  /// Le balayage radar tourne-t-il ?
  final bool scanning;

  /// Incrémenter pour rejouer le balayage (voir [RadarSweepOverlay.trigger]).
  final int scanTrigger;

  /// Centre de la carte : la position si on l'a, sinon le premier site, sinon
  /// un repli — la carte doit toujours pouvoir se construire.
  LatLng get _center {
    if (position != null) return position!;
    if (sites.isNotEmpty) {
      return LatLng(sites.first.latitude, sites.first.longitude);
    }
    return _kFallbackCenter;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Tokens.radiusLg),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _kDefaultZoom,
              // Carte de lecture : pas de rotation, elle désoriente plus
              // qu'elle n'aide sur un écran de pointage.
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: AppConfig.mapTileUrl,
                userAgentPackageName: _kUserAgent,
                tileProvider: NetworkTileProvider(),
              ),
              if (sites.isNotEmpty)
                CircleLayer(
                  circles: [
                    for (final site in sites)
                      CircleMarker(
                        point: LatLng(site.latitude, site.longitude),
                        // En mètres, pas en pixels : le cercle doit suivre le
                        // zoom pour représenter le vrai rayon autorisé.
                        radius: site.radiusMeters.toDouble(),
                        useRadiusInMeter: true,
                        color: colors.brand.withValues(alpha: 0.12),
                        borderColor: colors.brand.withValues(alpha: 0.45),
                        borderStrokeWidth: 2,
                      ),
                  ],
                ),
              if (position != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: position!,
                      width: _PositionDot.size,
                      height: _PositionDot.size,
                      child: const _PositionDot(),
                    ),
                  ],
                ),
              // Attribution de la source : obligatoire, jamais masquée.
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(AppConfig.mapAttribution),
                ],
              ),
            ],
          ),
          RadarSweepOverlay(isActive: scanning, trigger: scanTrigger),
        ],
      ),
    );
  }
}

/// Pastille de position : disque de marque cerclé de blanc, lisible sur
/// n'importe quelle tuile.
class _PositionDot extends StatelessWidget {
  const _PositionDot();

  static const size = 22.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.brand,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
