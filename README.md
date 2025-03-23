# 🚀 PocketBase2Delphi

PocketBase2Delphi is a library for connecting to the [PocketBase](https://pocketbase.io/) database using Delphi. It allows performing standard CRUD operations (Create, Read, Update, Delete) and adding listeners to tables using the `Subscribe` function.

## ✨ Features
- 🔄 **Standard CRUD**: Insert, read, update, and delete records.
- 🔔 **Subscribe**: Real-time monitoring of changes in collections.

## 📌 Usage Examples

### 🏗️ Class Definition
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

### 📥 Insert Records
```delphi
Post := TPosts.Create;
Post.title := 'Test 1';
Post.content := 'Sample content';
Post := ClientInstance.Collection.Insert<TPosts>(Post);
```

### 📜 Retrieve Records
```delphi
// Get a list of posts
ListaPosts := ClientInstance.Collection.GetList<TPosts>;

// Get a post by ID
Post := ClientInstance.Collection.GetById<TPosts>('Test123');
```

### ✏️ Update a Record
```delphi
Post := ClientInstance.Collection.GetById<TPosts>(Post.id);
Post.title := 'Updated Title';
Post.content := 'Updated Content';
Post := ClientInstance.Collection.Update<TPosts>(Post);
```

### 🗑️ Delete a Record
```delphi
if not ClientInstance.Collection.TryDelete<TPosts>(Post, ResultDeleteError) then
  raise Exception.Create(ResultDeleteError);
```

### 📡 Subscribe to Collection Changes
```delphi
ClientInstance.Collection.Subscribe(
  'posts',
  procedure(AData: ISuperObject)
  begin
    Memo1.Text := AData.AsJSon(True);
  end);
