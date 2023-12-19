# Greenbase2Delphi
## Exemplos de uso:
### Classe
```
  TPosts = class
  private
    FID     : string;
    FTitle  : string;
    FContent: string;
    FCreated: string;
    FUpdated: string;
  public
    property id     : string read FID write FID;
    property title  : string read FTitle write FTitle;
    property content: string read FContent write FContent;
    property created: string read FCreated write FCreated;
    property updated: string read FUpdated write FUpdated;

    function Equals(APost: TPosts): boolean; reintroduce;
  end;
```
### Implementação em código
```
  Post, post2, post3, post4: TPosts;
  ResultDeleteError        : string;
  ListaPosts               : TObjectList<TPosts>;
begin
  Post         := TPosts.Create;
  Post.title   := 'teste 1';
  Post.content := 'teststsas';

  post2         := TPosts.Create;
  post2.title   := 'teste 1';
  post2.content := 'teststsas';

  post3         := TPosts.Create;
  post3.title   := 'teste 1';
  post3.content := 'teststsas';

  post4         := TPosts.Create;
  post4.title   := 'teste 1';
  post4.content := 'teststsas';

  Post := ClientInstance
    .Collection
    .Insert<TPosts>(Post);

  post2 := ClientInstance
    .Collection
    .Insert<TPosts>(post2);

  post3 := ClientInstance
    .Collection
    .Insert<TPosts>(post3);

  post4 := ClientInstance
    .Collection
    .Insert<TPosts>(post4);

  ListaPosts := ClientInstance
    .Collection
    .GetList<TPosts>;

  ClientInstance
    .Collection
    .GetById<TPosts>('Teste123');

  Post         := TPosts.Create;
  Post.title   := 'Daniel Soares';
  Post.content := 'Lorem Ipsum Doret';
  Post         := ClientInstance
    .Collection
    .Insert<TPosts>(Post);

  post2 := ClientInstance
    .Collection
    .GetById<TPosts>(Post.id);

  post2.title   := 'Daniel Soares Alterado';
  post2.content := '123';

  post3 := ClientInstance
    .Collection
    .Update<TPosts>(post2);

  if
    not ClientInstance
    .Collection
    .TryDelete<TPosts>(post3, ResultDeleteError)
  then
    raise Exception.Create(ResultDeleteError);

  ClientInstance
    .Collection
    .Subscribe(
    'posts',
    procedure(AData: ISuperObject)
    begin
      Memo1.Text := AData.AsJSon(True);
    end);

end;
