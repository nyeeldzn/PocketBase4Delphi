unit Services.Utils.BaseService;

interface


type
  BaseService = class abstract
  private
    FClient: TObject;
  public

    constructor Create(AClient: TObject);

    property ClientInstance: TObject read FClient;
  end;

implementation

{ BaseService }

constructor BaseService.Create(AClient: TObject);
begin
  FClient := AClient;
end;

end.
