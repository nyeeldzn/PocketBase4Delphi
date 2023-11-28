unit Services.RecordService;

interface

uses
  Services.Utils.CrudServices;

type
  RecordService = class(CrudService)
  private
    FNameOrId: string;
    FNameURL: string;

    function baseCrudPath: string; override;
  public
    constructor Create(ABaseURL: string; ANameOrId: string); reintroduce;
  end;

implementation

{ RecordService }

function RecordService.baseCrudPath: string;
begin
  Result := FNameURL + '/api/collections/' + FNameOrId + '/records';
end;

constructor RecordService.Create(ABaseURL: string; ANameOrId: string);
begin
  inherited Create(nil);

  FNameURL := ABaseURL;
  FNameOrId := ANameOrId;
end;

end.
