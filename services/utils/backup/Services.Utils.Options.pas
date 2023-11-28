unit Services.Utils.Options;

interface

uses
  Generics.Collections,
  {$IfNDef FPC}
  System.JSON,
  {$ELSE}
   fpjson, jsonparser,
  {$EndIf}
  Services.Utils.Dtos;

type
  THeaders = TObjectList<TTuple>;
  TParams = TObjectList<TTuple>;

  { QueryOptions }

  QueryOptions = class
  private
    FHeaders: THeaders;
    FParams: TParams;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    property Headers: THeaders read FHeaders write FHeaders;
    property Params: TParams read FParams write FParams;
  end;

  CommonOptions = class(QueryOptions)
  private
    FFields: string;
  public
    property Fields: string read FFields write FFields;
  end;

  { THeadersHelper }

  TParamsHelper = class helper for TParams
    function GetParamString: string;
  end;


implementation

{ QueryOptions }

constructor QueryOptions.Create;
begin
  FHeaders := THeaders.Create;
  FParams := TParams.Create;
end;

destructor QueryOptions.Destroy;
begin
  FHeaders.Free;
  FParams.Free;

  inherited Destroy;
end;

{ THeadersHelper }

function TParamsHelper.GetParamString: string;
var
  Item: TTuple;
  I: integer;
begin

  if Self.Count > 0 then
    Result := '?';

  for I := 0 to Pred(Self.Count) do
  begin
    Item := Self[I];

    if I = Pred(Self.Count) then
      Result := Result + Item.key + '=' + Item.Value
    else
      Result := Result + Item.key + '=' + Item.Value + ',';
  end;

end;

end.
