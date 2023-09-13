import 'package:new_project_setup/constants/app.export.dart';

class CommonResponse<T> {
  String? status;
  String? message;
  T? data;
  List<T>? listData;
  Errors? errors;
  Meta? meta;

  CommonResponse({
    this.status,
    this.message,
    this.data,
    this.listData,
    this.errors,
    this.meta,
  });

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors'][0]) : null;
    if (json.containsKey("meta") && json["meta"] != null) {
      meta = Meta.fromJson(json['meta']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['message'] = message;
    data['data'] = data;
    data['errors'] = errors;
    try {
      if (errors != null) {
        data['errors'] = errors?.toJson();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (meta != null) {
      data['meta'] = meta?.toJson();
    }
    return data;
  }
}

// class CommonErrors {
//   String message;
//   Errors errors;
//
//   CommonErrors({this.message, this.errors});
//
//   CommonErrors.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.errors != null) {
//       data['errors'] = this.errors.toJson();
//     }
//     return data;
//   }
// }

class Errors {
  String? message;
  List<Errors>? errors;

  Errors({this.message, this.errors});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Context {
  String? label;
  String? value;
  String? key;

  Context({this.label, this.value, this.key});

  Context.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['key'] = key;
    return data;
  }
}

class ErrorResponse {
  String? status;
  Message? message;

  ErrorResponse({this.status, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message?.toJson();
    }
    return data;
  }
}

class Message {
  List<Details>? details;

  Message({this.details});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? message;
  List<String>? path;
  String? type;

  Details({this.message, this.path, this.type});

  Details.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    path = json['path'].cast<String>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['path'] = path;
    data['type'] = type;
    return data;
  }
}

class ErrorSimpleResponse {
  String? status;
  String? message;

  ErrorSimpleResponse({this.status, this.message});

  ErrorSimpleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Meta {
  int? total;
  int? lastPage;
  int? perPage;
  int? currentPage;
  int? from;
  int? to;

  Meta({this.total, this.lastPage, this.perPage, this.currentPage, this.from, this.to});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lastPage = json['lastPage'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['lastPage'] = lastPage;
    data['perPage'] = perPage;
    data['currentPage'] = currentPage;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
