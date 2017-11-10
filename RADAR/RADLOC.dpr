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
    constructor create(t0: real);   //�����������, �������� ���-�� ����� � �� ���������
    procedure peleng(ti: real);     //��������� �������� ���������� �� ���� � �������, � ����� ������, ���� � ������� ���������
    destructor des;                 //���������� (������)
  end;

var
  Radar: RLC;
  t0, time, tk: real;  //����� ������, ������� � ��������
  f: text; filename: string; //���� ��� ������ � ��� ���

constructor RLC.create(t0: real);
//������� ��������� ���������� � �������� ������� �����
var
  i: integer; init_ttype: integer;                   //��� ����
  init_x, init_y, init_v, init_acc, init_time: real; //��������� ��������� ��� �����
  air: TAircraft; mis: TMissle;                      //������� (����� ��� �������� �������)

begin
  write('Input radar coordinates: '); readln(x, y);  //������� ��������� ���
  write('Input radar radius: '); readln(R);          //������� ������� �����������
  write('Input targets amount: '); readln(tar);      //������� ���������� �����
  SetLength(targets, tar);

  //�������� ������� �����
  randomize;
  for I := 0 to tar-1 do begin
    init_ttype := random(2);                                              //����������� ����(��������� - ������/������)
    write('Input target initial coordinates: '); readln(init_x, init_y);  //������� ���������� ��������� ����
    write('Input target initial speed: '); readln(init_v);                //��������� ��������
    //������
    if init_ttype = 0 then
      targets[i] := TAircraft.create(init_x, init_y, init_v, t0, 0)
    //������
    else begin
      write('Input missle acceleration: '); readln(init_acc);             //����� ��� 1 ������� - ���������
      targets[i] := TMissle.create(init_x, init_y, init_v, init_acc, t0, 1);
    end;
  end;
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
      if targets[i].target_type = 0 then writeln(f, ' air')
      else writeln(f, ' mis');
    end;
  end;
  time := ti;         //���������� ������� ���
end;

destructor RLC.des;
begin

end;

begin
  write('Input start and finish simulation time: '); readln(t0, tk);    //������� ���������� � ��������� �������
  write('Input output file name: '); readln(filename);                  //���������� ����� �����
  assignfile(f, filename); rewrite(f);                                  //�������� �� ������
  writeln(f, ' Dist  ',';  Az   ',';num',';type');                      //����� ��� �����
  radar := RLC.create(t0);                                              //�������� ���
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
