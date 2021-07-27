// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaybackObject _$PlaybackObjectFromJson(Map<String, dynamic> json) {
  return PlaybackObject(
    contextUri: json['context_uri'] as String?,
    uris: (json['uris'] as List<dynamic>?)?.map((e) => e as String).toList(),
    offset: json['offset'],
    position: json['position_ms'] as int?,
  );
}

Map<String, dynamic> _$PlaybackObjectToJson(PlaybackObject instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('context_uri', instance.contextUri);
  writeNotNull('uris', instance.uris);
  writeNotNull('offset', instance.offset);
  val['position_ms'] = instance.position;
  return val;
}
