# 🚀 PocketBase2Delphi

PocketBase2Delphi é uma biblioteca para conexão com o banco de dados [PocketBase](https://pocketbase.io/) através do Delphi. Ela permite realizar operações CRUD (Create, Read, Update, Delete) e adicionar Listeners em tabelas usando a funcionalidade `Subscribe`.

## ✨ Funcionalidades
- 🔄 **CRUD Padrão**: Inserção, leitura, atualização e exclusão de registros.
- 🔔 **Subscribe**: Monitoramento de mudanças em tempo real em coleções.

## 📌 Exemplos de Uso

### 🏗️ Definição da Classe
```delphi
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

### 💻 Implementação em Código
```delphi
var
  Post, post2, post3, post4: TPosts;
  ResultDeleteError        : string;
  ListaPosts               : TObjectList<TPosts>;
begin
  // ✍️ Criando instâncias da classe
  Post := TPosts.Create;
  Post.title := 'teste 1';
  Post.content := 'teststsas';

  post2 := TPosts.Create;
  post2.title := 'teste 1';
  post2.content := 'teststsas';

  post3 := TPosts.Create;
  post3.title := 'teste 1';
  post3.content := 'teststsas';

  post4 := TPosts.Create;
  post4.title := 'teste 1';
  post4.content := 'teststsas';

  // 📥 Inserindo registros
  Post := ClientInstance.Collection.Insert<TPosts>(Post);
  post2 := ClientInstance.Collection.Insert<TPosts>(post2);
  post3 := ClientInstance.Collection.Insert<TPosts>(post3);
  post4 := ClientInstance.Collection.Insert<TPosts>(post4);

  // 📜 Obtendo lista de registros
  ListaPosts := ClientInstance.Collection.GetList<TPosts>;

  // 🔍 Obtendo um registro por ID
  ClientInstance.Collection.GetById<TPosts>('Teste123');

  // ✏️ Atualizando um registro
  Post := TPosts.Create;
  Post.title := 'Daniel Soares';
  Post.content := 'Lorem Ipsum Doret';
  Post := ClientInstance.Collection.Insert<TPosts>(Post);

  post2 := ClientInstance.Collection.GetById<TPosts>(Post.id);
  post2.title := 'Daniel Soares Alterado';
  post2.content := '123';
  post3 := ClientInstance.Collection.Update<TPosts>(post2);

  // 🗑️ Excluindo um registro
  if not ClientInstance.Collection.TryDelete<TPosts>(post3, ResultDeleteError) then
    raise Exception.Create(ResultDeleteError);

  // 📡 Monitorando mudanças na coleção "posts"
  ClientInstance.Collection.Subscribe(
    'posts',
    procedure(AData: ISuperObject)
    begin
      Memo1.Text := AData.AsJSon(True);
    end);
end;
```
