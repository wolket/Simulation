program RADLOC;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Targets in 'Targets.pas';

const dt = 0.1;

type
  RLC = class                 //���
    x,y: real; tar: integer;  //���������� � ���������� �����
    R: real; time: real;      //������ ����������� � �����
    targets: array of TTarget;      //������ �����
    constructor create(initParam: array of real);   //�����������
    procedure createTargets(initParam: array of real; ttype: TTargetType);
    procedure peleng(ti: real);     //��������� �������� ���������� �� ���� � �������, � ����� ������, ���� � ������� ���������
    destructor destroy;                 //���������� (������)
  end;

var
  Radar: RLC;
  initParam: array of real;
  targetCount, i, ttype: integer;
  t0, time, tk: real;  //����� ������, ������� � ��������
  f: text; //���� ��� ������

procedure GetDataTarget(var initParam: array of real; ttype: integer);
begin
  write('Vvedite nachalnoe polozhenie celi: '); readln(initParam[0], initParam[1]);
  initParam[2] := t0;
  write('Vvedite nachalnyu skorost: '); readln(initParam[3]);
  if (ttype = 1) then begin write('Vvedite yskorenie raketi: '); readln(initParam[4]); end;
end;

procedure GetDataRLC(var initParam: array of real);
begin
  write('Vvedite nachalnoe polozhenie radara: '); readln(initParam[0], initParam[1]);
  initParam[2] := t0;
  write('Vvedite Rmax: '); readln(initParam[3]);
end;

constructor RLC.create(initParam: array of real);
//������� ��������� ����������
begin
  tar := 0;
  x := initParam[0]; y := initParam[1];
  time := initParam[2];
  R := initParam[3];
end;

procedure RLC.createTargets(initParam: array of Real; ttype: TTargetType);
var Aircraft: TAircraft; Missile: TMissile;
begin
  inc(tar);
  setLength(Targets, tar);
  if ttype = Air then begin Aircraft := TAircraft.create(initParam); Targets[tar - 1] := Aircraft; end
  else begin Missile := TMissile.create(initParam); Targets[tar - 1] := Missile; end;
end;

procedure RLC.peleng(ti: real);
//��������, �������� �� ���� � ������� ����������� � ������ � ����
var
  i: Integer;
  D, Az: real;        //��������� � ������
begin
  for i := 0 to tar-1 do begin      //�������� �� ����� �������
    targets[i].move(ti);
    D := sqrt(sqr(x - targets[i].x)+sqr(y - targets[i].y));    //���������� ���������
    if D <= R then begin                                       //���� ���� � ������� ����������� �� ���������� ������ � ����
      Az := arctan((targets[i].y - y)/(targets[i].x - x));
      write(f, D:7:5,';', Az:7:5,';', i:3, ';');
      if targets[i].targettype = Air then writeln(f, ' air')
      else writeln(f, ' mis');
    end;
  end;
  time := ti;         //���������� ������� ���
end;

destructor RLC.destroy;
begin

end;

begin
  write('Input start and finish simulation time: '); readln(t0, tk);    //������� ���������� � ��������� �������
  assignfile(f, 'temp.txt'); rewrite(f);                                  //�������� �� ������
  writeln(f, ' Dist  ',';  Az   ',';num',';type');                      //����� ��� �����
  setLength(initParam, 4);
  GetDataRLC(initParam);                                              //�������� ���
  Radar := RLC.Create(initParam);
  write('Vvedite kolichestvo celei: '); readln(targetcount);
  for i := 0 to targetcount-1 do
  begin
    write('Vvedite tip celi(0 - Air, 1 - Mis): '); readln(ttype);
    if ttype = 0 then setLength(initParam, 4)
    else setLength(initParam, 5);
    GetDataTarget(initParam, ttype);
    if ttype = 0 then Radar.createTargets(initParam, Air)
    else Radar.createTargets(initParam, Mis);
  end;
  time := t0;                                                           //������� �����
  while time <= tk do begin                                             //�������� ����
    radar.peleng(time);                                                 //���������
    time := time + dt;                                                  //��������� �������
  end;
  writeln('Simulation finished');
  closefile(f);                                                         //�������� �����
  writeln('Hit <Enter> to exit.');
  readln;
end.                                                                    //��� ��)
