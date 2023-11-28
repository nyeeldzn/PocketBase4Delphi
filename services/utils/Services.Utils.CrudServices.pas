unit Services.Utils.CrudServices;

interface

uses
  SysUtils,
  IdHTTP,
  Classes,
  Generics.Collections,
  {$IFNDEF FPC}
  System.JSON,
  REST.JSON,
  {$ELSE}
   fpjson, jsonparser,
  {$ENDIF}
  Services.Utils.BaseService;

type
  CrudService = class(BaseService)
    function baseCrudPath(): string; virtual; abstract;
    function GetList(Page: integer = 1; PerPage: integer = 30;
      Options: TObject = nil): string;
  end;

implementation

function CrudService.GetList(Page: integer = 1; PerPage: integer = 30;
  Options: TObject = nil): string;
var
  IdHTTP: TIdHTTP;
  Response: TStringStream;
begin
  IdHTTP := TIdHTTP.Create(nil);
  Response := TStringStream.Create('');

  IdHTTP.Get(baseCrudPath(), Response);

  IdHTTP.Free();
end;

end.
