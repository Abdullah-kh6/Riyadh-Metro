import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

// Minimal stub for uploaded file class
class FFUploadedFile {
  final List<int>? bytes;
  final String? name;
  FFUploadedFile({this.bytes, this.name});
}

// Stubbed streaming response function
Future<http.StreamedResponse> getStreamedResponse(http.BaseRequest request) async {
  return await request.send();
}

enum ApiCallType { GET, POST, DELETE, PUT, PATCH }
enum BodyType { NONE, JSON, TEXT, X_WWW_FORM_URL_ENCODED, MULTIPART }

class ApiCallOptions {
  const ApiCallOptions({
    this.callName = '',
    required this.callType,
    required this.apiUrl,
    required this.headers,
    required this.params,
    this.bodyType,
    this.body,
    this.returnBody = true,
    this.encodeBodyUtf8 = false,
    this.decodeUtf8 = false,
    this.alwaysAllowBody = false,
    this.cache = false,
    this.isStreamingApi = false,
  });

  final String callName;
  final ApiCallType callType;
  final String apiUrl;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final BodyType? bodyType;
  final String? body;
  final bool returnBody;
  final bool encodeBodyUtf8;
  final bool decodeUtf8;
  final bool alwaysAllowBody;
  final bool cache;
  final bool isStreamingApi;
}

class ApiCallResponse {
  const ApiCallResponse(this.jsonBody, this.headers, this.statusCode, {this.response, this.streamedResponse, this.exception});

  final dynamic jsonBody;
  final Map<String, String> headers;
  final int statusCode;
  final http.Response? response;
  final http.StreamedResponse? streamedResponse;
  final Object? exception;

  bool get succeeded => statusCode >= 200 && statusCode < 300;
  String getHeader(String headerName) => headers[headerName] ?? '';
  String get bodyText => response?.body ?? (jsonBody is String ? jsonBody : jsonEncode(jsonBody));
  String get exceptionMessage => exception.toString();

  static ApiCallResponse fromHttpResponse(http.Response response, bool returnBody, bool decodeUtf8) {
    dynamic jsonBody;
    try {
      final body = decodeUtf8 && returnBody ? const Utf8Decoder().convert(response.bodyBytes) : response.body;
      jsonBody = returnBody ? json.decode(body) : null;
    } catch (_) {}
    return ApiCallResponse(jsonBody, response.headers, response.statusCode, response: response);
  }
}

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  static String? _accessToken;
  static final Map<ApiCallOptions, ApiCallResponse> _apiCache = {};

  static void clearCache(String callName) => _apiCache.removeWhere((k, _) => k.callName == callName);
  static Map<String, String> toStringMap(Map map) => map.map((k, v) => MapEntry(k.toString(), v.toString()));
  static String asQueryParams(Map<String, dynamic> map) => map.entries.map((e) => "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}").join('&');

  static Future<ApiCallResponse> urlRequest(ApiCallType callType, String apiUrl, Map<String, dynamic> headers, Map<String, dynamic> params, bool returnBody, bool decodeUtf8, bool isStreamingApi, {http.Client? client}) async {
    if (params.isNotEmpty) {
      final specifier = Uri.parse(apiUrl).queryParameters.isNotEmpty ? '&' : '?';
      apiUrl = '$apiUrl$specifier${asQueryParams(params)}';
    }
    if (isStreamingApi) {
      client ??= http.Client();
      final request = http.Request(callType.name, Uri.parse(apiUrl))..headers.addAll(toStringMap(headers));
      final streamedResponse = await getStreamedResponse(request);
      return ApiCallResponse(null, streamedResponse.headers, streamedResponse.statusCode, streamedResponse: streamedResponse);
    }
    final makeRequest = callType == ApiCallType.GET ? (client?.get ?? http.get) : (client?.delete ?? http.delete);
    final response = await makeRequest(Uri.parse(apiUrl), headers: toStringMap(headers));
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static Future<ApiCallResponse> requestWithBody(ApiCallType type, String apiUrl, Map<String, dynamic> headers, Map<String, dynamic> params, String? body, BodyType? bodyType, bool returnBody, bool encodeBodyUtf8, bool decodeUtf8, bool alwaysAllowBody, bool isStreamingApi, {http.Client? client}) async {
    final postBody = createBody(headers, params, body, bodyType, encodeBodyUtf8);
    if (isStreamingApi) {
      client ??= http.Client();
      final request = http.Request(type.name, Uri.parse(apiUrl))..headers.addAll(toStringMap(headers))..body = postBody;
      final streamedResponse = await getStreamedResponse(request);
      return ApiCallResponse(null, streamedResponse.headers, streamedResponse.statusCode, streamedResponse: streamedResponse);
    }
    final requestFn = {
      ApiCallType.POST: client?.post ?? http.post,
      ApiCallType.PUT: client?.put ?? http.put,
      ApiCallType.PATCH: client?.patch ?? http.patch,
      ApiCallType.DELETE: client?.delete ?? http.delete,
    }[type]!;
    final response = await requestFn(Uri.parse(apiUrl), headers: toStringMap(headers), body: postBody);
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static dynamic createBody(Map<String, dynamic> headers, Map<String, dynamic>? params, String? body, BodyType? bodyType, bool encodeBodyUtf8) {
    String? contentType;
    dynamic postBody;
    switch (bodyType) {
      case BodyType.JSON:
        contentType = 'application/json';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.TEXT:
        contentType = 'text/plain';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.X_WWW_FORM_URL_ENCODED:
        contentType = 'application/x-www-form-urlencoded';
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.MULTIPART:
        contentType = 'multipart/form-data';
        postBody = params;
        break;
      case BodyType.NONE:
      case null:
        break;
    }
    if (contentType != null && !headers.keys.any((h) => h.toLowerCase() == 'content-type')) {
      headers['Content-Type'] = contentType;
    }
    return encodeBodyUtf8 && postBody is String ? utf8.encode(postBody) : postBody;
  }

  Future<ApiCallResponse> call(ApiCallOptions options, {http.Client? client}) => makeApiCall(
    callName: options.callName,
    apiUrl: options.apiUrl,
    callType: options.callType,
    headers: options.headers,
    params: options.params,
    body: options.body,
    bodyType: options.bodyType,
    returnBody: options.returnBody,
    encodeBodyUtf8: options.encodeBodyUtf8,
    decodeUtf8: options.decodeUtf8,
    alwaysAllowBody: options.alwaysAllowBody,
    cache: options.cache,
    isStreamingApi: options.isStreamingApi,
    options: options,
    client: client,
  );

  Future<ApiCallResponse> makeApiCall({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool encodeBodyUtf8 = false,
    bool decodeUtf8 = false,
    bool alwaysAllowBody = false,
    bool cache = false,
    bool isStreamingApi = false,
    ApiCallOptions? options,
    http.Client? client,
  }) async {
    if (_accessToken != null) headers[HttpHeaders.authorizationHeader] = 'Bearer $_accessToken';
    if (!apiUrl.startsWith('http')) apiUrl = 'https://$apiUrl';
    final callOptions = options ?? ApiCallOptions(
      callName: callName,
      callType: callType,
      apiUrl: apiUrl,
      headers: headers,
      params: params,
      bodyType: bodyType,
      body: body,
      returnBody: returnBody,
      encodeBodyUtf8: encodeBodyUtf8,
      decodeUtf8: decodeUtf8,
      alwaysAllowBody: alwaysAllowBody,
      cache: cache,
      isStreamingApi: isStreamingApi,
    );
    if (cache && _apiCache.containsKey(callOptions)) return _apiCache[callOptions]!;
    try {
      final response = callType == ApiCallType.GET || (callType == ApiCallType.DELETE && !alwaysAllowBody)
        ? await urlRequest(callType, apiUrl, headers, params, returnBody, decodeUtf8, isStreamingApi, client: client)
        : await requestWithBody(callType, apiUrl, headers, params, body, bodyType, returnBody, encodeBodyUtf8, decodeUtf8, alwaysAllowBody, isStreamingApi, client: client);
      if (cache) _apiCache[callOptions] = response;
      return response;
    } catch (e) {
      return ApiCallResponse(null, {}, -1, exception: e);
    }
  }
}
