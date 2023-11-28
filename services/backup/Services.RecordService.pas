unit Services.RecordService;

interface

uses
  Services.Utils.Dtos,
  Services.Utils.CrudServices;

type

  { RecordService }

  RecordService = class(CrudService)
  private
    FNameOrId: string;
    FNameURL: string;

    function baseCrudPath: string; override;
  public
    constructor Create(AOwner: TObject; ABaseURL: string; ANameOrId: string);
      reintroduce;

    function StartPage(APageNumber: integer): RecordService;
    function ResultsPerPage(ARecordsNumber: integer): RecordService;
    function SortBy(ASortClause: string): RecordService;
    function FilterBy(AFilterClause: string): RecordService;
    function Fields(AFieldList: string): RecordService;
  end;

implementation

{ RecordService }

function RecordService.baseCrudPath: string;
begin
  Result := FNameURL + 'api/collections/' + FNameOrId + '/records';
end;

constructor RecordService.Create(AOwner: TObject; ABaseURL: string; ANameOrId: string);
begin
  inherited Create(AOwner);

  FNameURL := ABaseURL;
  FNameOrId := ANameOrId;
end;

function RecordService.StartPage(APageNumber: integer): RecordService;
begin
  FQueryOptions.Params.Add(TTuple.Create('page', IntToStr(APageNumber)));

  Result := Self;
end;

function RecordService.ResultsPerPage(ARecordsNumber: integer): RecordService;
begin
  FQueryOptions.Params.Add(TTuple.Create('perPage', IntToStr(ARecordsNumber)));

  Result := Self;
end;

function RecordService.SortBy(ASortClause: string): RecordService;
begin
  FQueryOptions.Params.Add(TTuple.Create('sort', ASortClause));

  Result := Self;
end;

function RecordService.FilterBy(AFilterClause: string): RecordService;
begin
  FQueryOptions.Params.Add(TTuple.Create('filter', AFilterClause));

  Result := Self;
end;

function RecordService.Fields(AFieldList: string): RecordService;
begin
  FQueryOptions.Params.Add(TTuple.Create('fields', AFieldList));

  Result := Self;
end;

end.
