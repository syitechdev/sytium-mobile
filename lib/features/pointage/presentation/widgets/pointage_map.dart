import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sytium_mobile/features/pointage/domain/pointage_models.dart';
import 'package:sytium_mobile/features/pointage/presentation/widgets/map_styles.dart';

const _kDefaultZoom = 16.5;

/// Cadre de repli tant qu'aucune position ni site n'est connu : Abidjan.
const _kFallbackCenter = LatLng(5.3599, -4.0083);

/// Carte plein cadre du pointage : zones autorisées de l'organisation et
/// position de l'employé, sur fond Google Maps accordé au thème.
///
/// Purement présentationnelle — elle ne décide de rien. Le verdict de zone
/// appartient au serveur ; le cercle affiché n'est qu'une aide à la lecture.
class PointageMap extends StatefulWidget {
  const PointageMap({
    required this.position,
    required this.sites,
    required this.zoneColor,
    this.bottomInset = 0,
    super.key,
  });

  /// Position de l'employé, nulle tant qu'elle n'est pas acquise.
  final LatLng? position;

  /// Zones actives de l'organisation, telles que renvoyées par l'API.
  final List<PointageZone> sites;

  /// Teinte des zones — elle suit le verdict, comme le radar.
  final Color zoneColor;

  /// Hauteur masquée par le sheet. Google Maps la retire de la zone utile, si
  /// bien que la position reste centrée dans la partie réellement visible.
  final double bottomInset;

  @override
  State<PointageMap> createState() => _PointageMapState();
}

class _PointageMapState extends State<PointageMap> {
  GoogleMapController? _controller;

  /// Centre : la position si on l'a, sinon le premier site, sinon un repli —
  /// la carte doit toujours pouvoir se construire.
  LatLng get _center {
    final position = widget.position;
    if (position != null) return position;
    if (widget.sites.isNotEmpty) {
      final site = widget.sites.first;
      return LatLng(site.latitude, site.longitude);
    }
    return _kFallbackCenter;
  }

  @override
  void didUpdateWidget(covariant PointageMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    // La position arrive après le premier rendu : on recadre dessus plutôt que
    // de laisser l'employé sur le cadre de repli.
    final position = widget.position;
    if (position != null && position != oldWidget.position) {
      _controller?.animateCamera(CameraUpdate.newLatLng(position));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GoogleMap(
      // Force la reconstruction au changement de thème : le style ne se
      // réapplique pas sur une carte déjà créée.
      key: ValueKey('pointage_map_$isDark'),
      style: isDark ? MapStyles.dark : MapStyles.light,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: _kDefaultZoom,
      ),
      onMapCreated: (controller) => _controller = controller,
      padding: EdgeInsets.only(bottom: widget.bottomInset),
      // Le point bleu natif suffit ; l'écran pilote lui-même le cadrage, donc
      // ni bouton de recentrage ni contrôles de zoom.
      myLocationEnabled: widget.position != null,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      // Carte de lecture : ni rotation ni inclinaison, elles désorientent plus
      // qu'elles n'aident sur un écran de pointage.
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      circles: {
        for (final site in widget.sites)
          Circle(
            circleId: CircleId(site.id),
            center: LatLng(site.latitude, site.longitude),
            // En mètres : le cercle représente le vrai rayon autorisé.
            radius: site.radiusMeters.toDouble(),
            fillColor: widget.zoneColor.withValues(alpha: 0.12),
            strokeColor: widget.zoneColor.withValues(alpha: 0.55),
            strokeWidth: 2,
          ),
      },
      markers: {
        for (final site in widget.sites)
          Marker(
            markerId: MarkerId('site_${site.id}'),
            position: LatLng(site.latitude, site.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            infoWindow: InfoWindow(title: site.nom ?? 'Site de pointage'),
          ),
      },
    );
  }
}
