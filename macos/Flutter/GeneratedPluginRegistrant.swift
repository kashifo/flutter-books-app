//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import connectivity_plus
import just_audio
import path_provider_foundation
import sqflite
import url_launcher_macos
import wakelock_macos
import webview_universal

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  ConnectivityPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
  WakelockMacosPlugin.register(with: registry.registrar(forPlugin: "WakelockMacosPlugin"))
  WebviewUniversalPlugin.register(with: registry.registrar(forPlugin: "WebviewUniversalPlugin"))
}
