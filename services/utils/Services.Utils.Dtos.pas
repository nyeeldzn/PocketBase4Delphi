unit Services.Utils.Dtos;

interface

uses
  {$IFnDEF FPC}
  System.JSON;
  {$ELSE}
  fpjson, jsonparser;
  {$ENDIF}

type
  ListResult<T> = record
    page: Integer;
    perPage: Integer;
    totalItems: Integer;
    totalPages: Integer;
    items: array of T;
  end;

  BaseModel = class
    id: string;
    created: string;
    updated: string;
   // otherFields: array of TJsonPair; // Replace TKeyValue with appropriate type
  end;

  AdminModel = class(BaseModel)
    avatar: Integer;
    email: string;
  end;

  SchemaField = record
    id: string;
    name: string;
    &type: string;
    System: Boolean;
    required: Boolean;
    //options: array of TJsonPair; // Replace TKeyValue with appropriate type
  end;

  CollectionModel = class(BaseModel)
    name: string;
    &type: string;
    schema: array of SchemaField;
    indexes: array of string;
    System: Boolean;
    listRule: string;
    viewRule: string;
    createRule: string;
    updateRule: string;
    deleteRule: string;
    //options: array of TJsonPair;
  end;

  ExternalAuthModel = class(BaseModel)
    recordId: string;
    collectionId: string;
    provider: string;
    providerId: string;
  end;

  LogRequestModel = class(BaseModel)
    url: string;
    method: string;
    status: Integer;
    auth: string;
    remoteIp: string;
    userIp: string;
    referer: string;
    userAgent: string;
    //meta: array of TJsonPair;
  end;

  RecordModel = class(BaseModel)
    collectionId: string;
    collectionName: string;
   // expand: array of TJsonPair; // Replace TKeyValue with appropriate type
  end;

implementation

end.
