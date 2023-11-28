unit Services.CollectionServices;

interface

uses
  Services.Utils.CrudServices,
  Services.Utils.Dtos;

type
  CollectionService = class(CrudService)
     function baseCrudPath(): string; override;
  end;

implementation

{ CollectionService }

function CollectionService.baseCrudPath: string;
begin
  result := '/api/collections';
end;

end.
