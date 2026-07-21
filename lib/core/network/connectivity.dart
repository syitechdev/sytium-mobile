import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity.g.dart';

/// Vrai dès qu'une interface réseau est active.
///
/// C'est un indice, pas une garantie : une interface montée ne dit pas que le
/// serveur répond. Le flux sert donc à déclencher une nouvelle tentative, jamais
/// à décider seul qu'on est en ligne.
@Riverpod(keepAlive: true)
Stream<bool> networkAvailable(Ref ref) => Connectivity().onConnectivityChanged
    .map((results) => results.any((r) => r != ConnectivityResult.none));
