program dkr5kod1;

type
  TComparator = function(a, b: Integer): Boolean;

var
  comparator: TComparator;

function Greater(a, b: Integer): Boolean;
begin
  Result := a > b;
end;

function Less(a, b: Integer): Boolean;
begin
  Result := a < b;
end;

procedure Swap(var a, b: Integer);
var
  temp: Integer;
begin
  temp := a;
  a := b;
  b := temp;
end;

procedure InsertionSort(var arr: array of Integer);
var
  i, j, key: Integer;
begin
  for i := 1 to High(arr) do
  begin
    key := arr[i];
    j := i - 1;

    while (j >= 0) and comparator(arr[j], key) do
    begin
      arr[j + 1] := arr[j];
      j := j - 1;
    end;

    arr[j + 1] := key;
  end;
end;

procedure WriteDataToFile(arr: array of Integer);
var
  fileOut: Text;
  i: Integer;
begin
  Assign(fileOut, 'C:\Users\nikar\OneDrive\Рабочий стол\output.txt');
  Rewrite(fileOut);
  for i := 0 to High(arr) do
    Writeln(fileOut, arr[i]);
  Close(fileOut);
end;

var
  arr: array of Integer;
  n, i: Integer;
  inputFile: Text;

begin
  Assign(inputFile, 'C:\Users\nikar\OneDrive\Рабочий стол\input.txt');
  Reset(inputFile);

  ReadLn(inputFile, n);
  SetLength(arr, n);

  for i := 0 to n - 1 do
  begin
    ReadLn(inputFile, arr[i]);
  end;

  Close(inputFile);

  Write('Выберите тип сортировки (1 - по убыванию, 2 - по возрастанию): ');
  ReadLn(i);

  if i = 1 then
    comparator := Greater
  else if i = 2 then
    comparator := Less
  else
  begin
    Writeln('Некорректный выбор сортировки.');
    Exit;
  end;

  InsertionSort(arr);
  WriteDataToFile(arr);

  Writeln('Сортировка выполнена. Результат записан в файл output.txt');
end.
