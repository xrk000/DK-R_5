program dkr5;

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

procedure Merge(var arr: array of Integer; left, mid, right: Integer);
var
i, j, k: Integer;
n1, n2: Integer;
L, R: array of Integer;
begin
n1 := mid - left + 1;
n2 := right - mid;

SetLength(L, n1);
SetLength(R, n2);

for i := 0 to n1 - 1 do
L[i] := arr[left + i];
for j := 0 to n2 - 1 do
R[j] := arr[mid + 1 + j];

i := 0;
j := 0;
k := left;

while (i < n1) and (j < n2) do
begin
if comparator(L[i], R[j]) then
begin
arr[k] := L[i];
Inc(i);
end
else
begin
arr[k] := R[j];
Inc(j);
end;
Inc(k);
end;

while i < n1 do
begin
arr[k] := L[i];
Inc(i);
Inc(k);
end;

while j < n2 do
begin
arr[k] := R[j];
Inc(j);
Inc(k);
end;
end;

procedure MergeSort(var arr: array of Integer; left, right: Integer);
var
mid: Integer;
begin
if left < right then
begin
mid := (left + right) div 2;

MergeSort(arr, left, mid);
MergeSort(arr, mid + 1, right);

Merge(arr, left, mid, right);
end;
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

Write('Выберите метод сортировки (1 - сортировка слиянием, 2 - сортировка вставками): ');
ReadLn(i);

if i = 1 then
begin
Write('Выберите тип сортировки (1 - по убыванию, 2 - по возрастанию): ');
ReadLn(i);

if i = 1 then
comparator := Greater
else if i = 2 then
comparator := Less
else
begin
Writeln('Некорректный выбор сортировки. Программа завершена.');
Exit;
end;

MergeSort(arr, 0, High(arr));
end
else if i = 2 then
begin
Write('Выберите тип сортировки (1 - по возрастанию, 2 - по убыванию): ');
ReadLn(i);

if i = 1 then
comparator := Greater
else if i = 2 then
comparator := Less
else
begin
Writeln('Некорректный выбор сортировки. Программа завершена.');
Exit;
end;

InsertionSort(arr);
end
else
begin
Writeln('Некорректный выбор сортировки. Программа завершена.');
Exit;
end;

WriteDataToFile(arr);

Writeln('Сортировка выполнена. Результат записан в файл output.txt');
end.