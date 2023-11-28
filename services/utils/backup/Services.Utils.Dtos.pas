unit Services.Utils.Dtos;

interface

uses
  {$IFnDEF FPC}
  System.JSON;

  {$ELSE}
  fpjson, jsonparser;
  {$ENDIF}

type
  TTuple = class
  private
    fKey: string;
    fValue: variant;
  public
    constructor Create(AKey: string; AValue: variant);

    property key: string read fkey write fkey;
    property Value: variant read fValue write fValue;
  end;

  ListResult<T> = record
    page: integer;
    perPage: integer;
    totalItems: integer;
    totalPages: integer;
    items: array of T;
  end;

  BaseModel = class
    id: string;
    created: string;
    updated: string;
    // otherFields: array of TJsonPair; // Replace TKeyValue with appropriate type
  end;

  AdminModel = class(BaseModel)
    avatar: integer;
    email: string;
  end;

  SchemaField = record
    id: string;
    Name: string;
    &type: string;
    System: boolean;
    required: boolean;
    //options: array of TJsonPair; // Replace TKeyValue with appropriate type
  end;

  CollectionModel = class(BaseModel)
    Name: string;
    &type: string;
    schema: array of SchemaField;
    indexes: array of string;
    System: boolean;
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
    status: integer;
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
