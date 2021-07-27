import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playback_object.g.dart';

@immutable
@JsonSerializable()
class PlaybackObject {
  @JsonKey(name: 'context_uri', includeIfNull: false)
  final String? contextUri;

  @JsonKey(includeIfNull: false)
  final List<String>? uris;

  @JsonKey(includeIfNull: false)
  final Object? offset;

  @JsonKey(name: 'position_ms', includeIfNull: false)
  final int position;

  const PlaybackObject({
    this.contextUri,
    this.uris,
    this.offset,
    int? position
  }) :
    position = position ?? 0;

	factory PlaybackObject.fromJson(Map<String, dynamic> json) => _$PlaybackObjectFromJson(json);
	Map<String, dynamic> toJson() => _$PlaybackObjectToJson(this);
}