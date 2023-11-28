unit Services.Utils.CrudServices;

interface

uses
  SysUtils,
  IdSSLOpenSSL,
  IdHTTP,
  Classes,
  Generics.Collections,
  {$IFNDEF FPC}
  System.JSON,
  REST.JSON,
  {$ELSE}
   fpjson, jsonparser,
  {$ENDIF}
  Variants,
  Services.Utils.Dtos,
  Services.Utils.Options,
  Services.Utils.BaseService;

type

  { CrudService }

  CrudService = class(BaseService)
    FQueryOptions: QueryOptions;

    constructor Create(AOwner: TObject); reintroduce;
    destructor Destroy; override;
    function baseCrudPath(): string; virtual; abstract;

    function GetList(Options: QueryOptions = nil): string;
    function GetById(AID: string): string;
    function Insert(const AData: string): string;
  end;

implementation

constructor CrudService.Create(AOwner: TObject);
begin
  inherited Create(AOwner);

  FQueryOptions := QueryOptions.Create;
end;

destructor CrudService.Destroy;
begin
  FQueryOptions.Free;

  inherited Destroy;
end;

function CrudService.GetList(Options: QueryOptions = nil): string;
var
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  Header: TTuple;
  Url: string;
begin
  IdHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);
  IdSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  IdHTTP.IOHandler := IdSSL;
  Url := baseCrudPath();

  if Assigned(Options) then
  begin
    FQueryOptions := Options;
  end;

  if Assigned(FQueryOptions) then
  begin

    for Header in FQueryOptions.Headers do
    begin
      IdHTTP.Request.CustomHeaders.AddValue(Header.key, VarToStr(Header.Value));
    end;

    Url := baseCrudPath() + FQueryOptions.Params.GetParamString;
  end;

  Result := IdHTTP.Get(Url);

  IdHTTP.Free();
end;

function CrudService.GetById(AID: string): string;
var
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  Header: TTuple;
  Url: string;
begin
  IdHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);
  IdSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  IdHTTP.IOHandler := IdSSL;
  Url := baseCrudPath();

  if Assigned(FQueryOptions) then
  begin

    for Header in FQueryOptions.Headers do
    begin
      IdHTTP.Request.CustomHeaders.AddValue(Header.key, VarToStr(Header.Value));
    end;

    Url := baseCrudPath() + '/' + AID + FQueryOptions.Params.GetParamString;
  end;

  Result := IdHTTP.Get(Url);

  IdHTTP.Free();
end;

function CrudService.Insert(const AData: string): string;
var
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  Header: TTuple;
  JSONBody: TStringStream;
  Url: string;
begin
  IdHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);
  IdSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  IdHTTP.IOHandler := IdSSL;
  Url := baseCrudPath();

  JSONBody := TStringStream.Create(AData);

  if Assigned(FQueryOptions) then
  begin
    Url := baseCrudPath() + FQueryOptions.Params.GetParamString;
  end;

  IdHTTP.Request.ContentType := 'application/json';
  IdHTTP.Request.Accept := '*/*';

  try
    try
      Result := IdHttp.Post(URL, JSONBody);
    finally
      IdHTTP.Free();
    end;
  except
    on E: Exception do
      raise E;
  end;

end;

end.
